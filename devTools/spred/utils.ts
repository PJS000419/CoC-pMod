/*
 * Created by aimozg on 10.08.2017.
 * Confidential until published on GitHub
 */
///<reference path="typings/jquery.d.ts"/>
type TDrawable = HTMLImageElement | HTMLCanvasElement | HTMLVideoElement | ImageBitmap;

function RGBA(i: tinycolorInstance): number {
	let rgb = i.toRgb();
	return (
			   ((rgb.a * 0xff) & 0xff) << 24
			   | (rgb.b & 0xff) << 16
			   | (rgb.g & 0xff) << 8
			   | (rgb.r & 0xff)
		   ) >>> 0;
}

function bound(min:number,x:number,max:number=Infinity):number {
	return min < x ? x < max ? x : max : min;
}

function randint(n: number): number {
	return Math.floor(Math.random() * n);
}

function randel<T>(arr: T[]): T {
	return arr[randint(arr.length)];
}

function $new(selector: string = 'div', ...content: (string | JQuery | Element | JQuery[] | Element[])[]): JQuery {
	let ss      = selector.split(/\./);
	let tagName = ss[0] || 'div';
	let d       = document.createElement(tagName);
	d.className = ss.slice(1).join(' ');
	if (tagName == 'button') (d as HTMLButtonElement).type = 'button';
	if (tagName == 'a') (d as HTMLAnchorElement).href = 'javascript:void(0)';
	let j = $(d);
	for (let c of content) j.append(c);
	return j;
}

type Dict<T> = { [index: string]: T };

function obj2kvpairs<T>(o: Dict<T>): [string, T][] {
	let rslt: [string, T][] = [];
	for (let i = 0, a = Object.keys(o), n = a.length; i < n; i++) {
		rslt[i] = [a[i], o[a[i]]];
	}
	return rslt;
}

function colormap(src: ImageData, map: [number, number][]): ImageData {
	let dst  = new ImageData(src.width, src.height);
	let sarr = new Uint32Array(src.data.buffer);
	let darr = new Uint32Array(dst.data.buffer);
	for (let i = 0, n = darr.length; i < n; i++) {
		darr[i] = sarr[i];
		for (let j = 0, m = map.length; j < m; j++) {
			if (sarr[i] === map[j][0]) {
				darr[i] = map[j][1];
				break;
			}
		}
	}
	return dst;
}

/*
 * Takes a rect starting from (srcdx, srcdy) of size (srcw x srch) from src
 * Scales it `scale` times.
 * Puts in onto dst starting from (dstdx, dstdy), with a dst bounds limited at (dstw x dsth)
 */
function drawImage(src: TDrawable, srcdx: number, srcdy: number, srcw: number, srch: number,
				   dst: CanvasRenderingContext2D, dstdx: number, dstdy: number, dstw: number, dsth: number,
				   scale: number) {
	let sx = srcdx, sy = srcdy, sw = srcw, sh = srch;
	let dx = dstdx, dy = dstdy;
	if (dx < 0) {
		sx -= dx;
		dx = 0;
	}
	if (dy < 0) {
		sy -= dy;
		dy = 0;
	}
	if (dx + sw > dstw) sw = dstw - dx;
	if (dy + sh > dsth) sh = dsth - dy;
	dst.drawImage(src, sx, sy, sw, sh, dx * scale, dy * scale, sw * scale, sh * scale);
}

namespace utils {
	export const basedir                 = window['spred_basedir'] || '../../';
	export const canAjax                 = location.protocol != 'file:';
	
	namespace FileAsker {
		let fileReaders = {} as Dict<(data: File) => any>;
		
		export function filename(f: string): string {
			let j = f.lastIndexOf('/');
			if (j >= 0) return f.substring(j + 1);
			return f;
		}
		
		export function wantFile(f: string) {
			return filename(f) in fileReaders;
		}
		
		function checkFiles(e: Event) {
			let filesArray = (e.target as HTMLInputElement).files;
			for (let i = 0; i < filesArray.length; i++) {
				let file    = filesArray[i];
				let name    = filename(file.name);
				let handler = fileReaders[name];
				if (handler) {
					delete fileReaders[name];
					handler(file);
				}
			}
			
		}
		
		export function askFile(url: string, handler: (File) => any) {
			let fileinput = $new('input').attr('type', 'file').attr('multiple', 'true').change(checkFiles);
			let dropzone  = $new('p',
				'Please select manually the ',
				$new('code', url),
				' file:',
				fileinput);
			$('#LoadingList').append(dropzone);
			$('#Loading').show();
			fileReaders[filename(url)] = (file) => {
				dropzone.remove();
				$('#Loading').toggle($('#LoadingList>*').length > 0);
				handler(file);
			}
		}
	}
	export function url2img(src: string): Promise<HTMLImageElement> {
		return new Promise<HTMLImageElement>((resolve, reject) => {
			let img    = document.createElement('img');
			img.onload = (e) => {
				resolve(img);
			};
			img.src    = src;
		});
	}
	
	export function loadFile(url: string, format: 'xml'): Promise<XMLDocument>;
	export function loadFile(url: string, format: 'text'): Promise<string>;
	export function loadFile(url: string, format: 'img'): Promise<HTMLImageElement>;
	export function loadFile(url: string, format: string): Promise<any> {
		
		return new Promise<any>((resolve, reject) => {
			if (!canAjax) {
				FileAsker.askFile(url, file => {
					if (format == 'img') {
						url2img(URL.createObjectURL(file)).then(resolve);
					} else {
						let fr    = new FileReader();
						fr.onload = () => {
							if (format == 'xml') {
								resolve($.parseXML(fr.result as string));
							} else {
								resolve(fr.result);
							}
							return;
						};
						fr.readAsText(file);
					}
				});
			} else if (format != 'img') {
				$.ajax(url, {dataType: format}).then(resolve).fail(reject);
			} else url2img(url).then(resolve);
		});
	}
	export function xmlget(x:Element,query:string):string|undefined {
		let m:string[];
		let orig = query;
		while (query && x) {
			if ((m = query.match(/^ *>? *([\w_-]+) */))) {
				x = Array.from(x.children).find(e => e.tagName.toUpperCase() == m[1].toUpperCase());
				query = query.substring(m[0].length);
			} else if ((m = query.match(/^ *@ *([\w_-]+) *$/))) {
				query = query.substring(m[0].length);
				let a = x.getAttribute(m[1]);
				if (a === null) return undefined;
				return a;
			} else {
				throw 'Bad selector "'+orig+'", halted on "'+query+'"';
			}
		}
		if (!x) return undefined;
		return x.innerHTML;
	}
	export function unindent(s:string|undefined):string|undefined {
		if (s === undefined) return undefined;
		let m = s.match(/^(\n\s+)/);
		if (m) s = s.replace(new RegExp(m[1],'g'),'\n').substr(1);
		s = s.replace(/(\n\s+)$/,'');
		return s;
	}
	export function xmlgeti(x:Element,query:string):number|undefined {
		let s = xmlget(x,query);
		if (s === undefined) return undefined;
		return (+s)|0;
	}
	export function xmlgetf(x:Element,query:string):number|undefined {
		let s = xmlget(x,query);
		if (s === undefined) return undefined;
		return +s;
	}
	export function parseLength(s:string|number):number;
	export function parseLength(s:undefined):undefined;
	export function parseLength(s:string|number|undefined):number|undefined {
		if (typeof s === 'undefined') return undefined;
		if (typeof s === 'number') return s;
		if (!isNaN(+s)) return +s;
		let m: RegExpMatchArray;
		if ((m = s.match(/^(?:(\d+)')(?:(\d+)")?$/))) {
			return (+m[1])*12+ +m[2];
		} else if ((m = s.match(/^(?:(\d+)m)?\s*(?:(\d+)cm)$/))) {
			let cm:number = (+m[1])*100 + +m[2];
			return +(cm/2.54);
		} else {
			throw "Not a valid length: " + JSON.stringify(s);
		}
	}
	export function lengthString(n:number|undefined):string|undefined {
		if (n === undefined) return undefined;
		if (n > -0.05 && n < +0.05) return '0';
		let s = '';
		if (n < 0) {
			s = '-';
			n = -n;
		}
		let ft = (n/12)|0;
		if (ft>0) s += ft+"'";
		let ic = (((n - ft*12)*10)|0)/10;
		if (ic != (ic|0)) s += ic.toFixed(1)+'"';
		else if (ic != 0) s += ic.toFixed(0)+'"';
		return s;
	}
	export function dictLookup(dict:any, s:string|undefined):number|undefined {
		if (typeof s === 'undefined') return undefined;
		if (s in dict) return dict[s];
		if (!isNaN(+s)) return +s;
		throw "Not a valid number or enum constant: "+JSON.stringify(s);
	}
	export function dictLookupName(dict:any, s:number|undefined):string|undefined {
		if (s === undefined) return undefined;
		if (s in dict) return dict[s];
		return ""+s;
	}
	export function enumNames(E:any):string[] {
		return Object.keys(E).filter(k => typeof E[k as any] === "number");
	}
	export function enumValues(E:any):string[] {
		return enumNames(E).map(k => E[k as any]);
	}
	export function enumAsOptions(E:any):HTMLOptionElement[] {
		return enumNames(E).map(k=>
			$('<option>').val(E[k]).html(k)[0] as HTMLOptionElement
		)
	}
}