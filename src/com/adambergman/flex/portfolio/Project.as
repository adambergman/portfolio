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
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Project extends EventDispatcher
	{	
		private var _name:String = "";
		private var _link:String = "";
		private var _description:String = "";
		private var _image:String = "";
		private var _imageData:Bitmap;
		
		public var index:Number = 0;
		
		public var technologies:ArrayCollection;  
		
		public var screenshots:ArrayCollection;
		
		public function Project(name:String="", description:String="", image:String="", link:String="", techstring:String="")
		{
			_name = name;
			_link = link;
			_description = description;
			_image = image;
			screenshots = new ArrayCollection();
			technologies = new ArrayCollection();
			var arr:Array = techstring.split(",");
			for(var i:Number = 0; i < arr.length; i++)
			{
				var icon:IconData = new IconData();
				switch(arr[i])
				{
					case "ai":
						icon.source = "assets/icons/ai.png";
						icon.tooltip = "Adobe Illustrator";
					break;
					case "mysql":
						icon.source = "assets/icons/mysql.png";
						icon.tooltip = "MySQL";
					break;
					case "mssql":
						icon.source = "assets/icons/mssql.png";
						icon.tooltip = "Microsoft SQL Server";
					break;
					case "ps":
						icon.source = "assets/icons/ps.png";
						icon.tooltip = "Adobe Photoshop";
					break; 
					case "xcode":
						icon.source = "assets/icons/xcode.png";
						icon.tooltip = "XCode";
					break; 
					case "coda":
						icon.source = "assets/icons/coda.png";
						icon.tooltip = "Coda";
					break;
					case "dw":
						icon.source = "assets/icons/dw.png";
						icon.tooltip = "Adobe Dreamweaver";
					break;
					case "php":
						icon.source = "assets/icons/php.png";
						icon.tooltip = "PHP";
					break;
					case "vs":
						icon.source = "assets/icons/vs.png";
						icon.tooltip = "Microsoft Visual Studio";
					break;
					case "java":
						icon.source = "assets/icons/java.png";
						icon.tooltip = "Java";
					break;
					case "html":
						icon.source = "assets/icons/text-html.png";
						icon.tooltip = "HTML/DHTML";
					break;
					case "eclipse":
						icon.source = "assets/icons/eclipse.png";
						icon.tooltip = "Eclipse IDE";
					break;
					case "flex":
						icon.source = "assets/icons/flex.png";
						icon.tooltip = "Adobe Flex";
					break;
					case "flash":
						icon.source = "assets/icons/flash.png";
						icon.tooltip = "Adobe Flash";
					break;
					default:
						icon.source = "assets/icons/text-html.png";
						icon.tooltip = arr[i];
					break;
				}
				technologies.addItem(icon);
			}
		}
		
		public function loadImage():void
		{
			var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
             var request:URLRequest = new URLRequest(_image);
            loader.load(request);
		}
		
		private function completeHandler(event:Event):void {
            var loader:Loader = Loader(event.target.loader);
            _imageData = Bitmap(loader.content);
            this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_SUCCESS, null));
        }
        
        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("Unable to load image: " + image);
            _imageData = new Bitmap();
             this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_SUCCESS, null));
        }
		
		public function get imageData():Bitmap
		{
			return _imageData;
		}

		public function set imageData(v:Bitmap):void
		{
			_imageData = v;
		}	

		public function get image():String
		{
			return _image;
		}

		public function set image(v:String):void
		{
			_image = v;
		}

		public function get description():String
		{
			return _description;
		}

		public function set description(v:String):void
		{
			_description = v;
		}

		public function get link():String
		{
			return _link;
		}

		public function set link(v:String):void
		{
			_link = v;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(v:String):void
		{
			_name = v;
		}
	}
}