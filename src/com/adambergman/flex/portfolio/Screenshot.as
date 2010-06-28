/*

This source code is provided as-is.  It is Copyright 2009-2010 Adam Bergman.
You may use parts of this source code in your projects, however you MAY NOT
repost this portfolio as your own with your own projects.  Images included
are copyrights of their respective owners.

You MAY NOT to repost or redistribute this source code with out expressed
written permission from the author.

If you find this code useful please comment at my blog: adambergman.com
Permalink: http://adambergman.com/2010/05/14/portfolio-source-code-updated/

*/

package com.adambergman.flex.portfolio
{
	import com.adambergman.flex.portfolio.events.ProjectLoadEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class Screenshot extends EventDispatcher
	{
		
		private var _title:String = "";
		private var _image:String = "";
		private var _imageData:Bitmap;
		
		public function Screenshot()
		{
		}
		
		public function loadImage():void
		{
			var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
             var request:URLRequest = new URLRequest(_image);
            loader.load(request);
		}
		
		private function completeHandler(event:Event):void 
		{
            var loader:Loader = Loader(event.target.loader);
            _imageData = Bitmap(loader.content);
            this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_SUCCESS, null, true));
        }
        
        private function ioErrorHandler(event:IOErrorEvent):void 
		{
            _imageData = new Bitmap();
             this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_SUCCESS, null, true));
        }
        
        [Bindable] public function get imageData():Bitmap
		{
			return _imageData;
		}

		public function set imageData(v:Bitmap):void
		{
			_imageData = v;
		}	
		
		[Bindable] public function get title():String
		{
			return _title;
		}

		public function set title(v:String):void
		{
			_title = v;
		}
		
		[Bindable] public function get image():String
		{
			return _image;
		}

		public function set image(v:String):void
		{
			_image = v;
		}	
	}
}