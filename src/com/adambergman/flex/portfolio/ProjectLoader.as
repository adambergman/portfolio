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
	
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import mx.collections.ArrayCollection;

	public class ProjectLoader extends EventDispatcher
	{
		[Bindable] public var projects:ArrayCollection = new ArrayCollection();
		[Bindable] public var imagesTotal:Number = 0;
		[Bindable] public var imagesLoaded:Number = 0;
		
		public function ProjectLoader() 
		{
			projects = new ArrayCollection();
		}
		
		public function load(url:String):void
		{
			this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_START, null));
			var initLoader:URLLoader = new URLLoader();
			initLoader.addEventListener(Event.COMPLETE, initLoaderComplete);
			initLoader.addEventListener(IOErrorEvent.IO_ERROR, initLoaderIOError);
			initLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, initLoaderSecurityError);
			initLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, initLoaderOnStatus);
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.GET;		
			initLoader.load(request);
		}
		
		private function initLoaderComplete(evt:Event):void
		{
			try
			{
				var xml:XML = new XML(evt.target.data);	
				if(xml.localName() != "projects")
				{
					this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_ERROR, "Invalid Namespace"));
					return;
				}
				var a:Number = 0;
				for each(var child:XML in xml.children())
				{
					//trace("found project");
					var proj:Project = new Project(child.name, child.description, child.image, child.link, child.technologies);
					imagesTotal++;
					proj.index = a;
					a++;
					proj.addEventListener(ProjectLoadEvent.XML_SUCCESS, addToImagesLoaded);
					proj.loadImage();
					for each(var sschild:XML in child.screenshots.children())
					{
						//trace("found ss");
						if(sschild.localName() == "screenshot")
						{
							var ss:Screenshot = new Screenshot();
							ss.title = sschild.title;
							ss.image = sschild.image;
							imagesTotal++;
							ss.addEventListener(ProjectLoadEvent.XML_SUCCESS, addToImagesLoadedSS);
							ss.loadImage();
							//trace('added ss');
							proj.screenshots.addItem(ss);
						}
					}
					projects.addItem(proj);
				}
				
			}
			catch(error:Error)
			{
				this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_ERROR, error.message));
			}			
		}
		
		private function addToImagesLoadedSS(event:ProjectLoadEvent):void
		{
			imagesLoaded++;
			if(imagesLoaded >= imagesTotal)
			{
				this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_SUCCESS, null, true));
			}
			this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_START, imagesLoaded, true));
			//trace("addToImagesLoadedSS    imagesLoaded = " + imagesLoaded + " imagesTotal = " + imagesTotal);
		}
		
		private function addToImagesLoaded(event:ProjectLoadEvent):void
		{
			imagesLoaded++;
			if(imagesLoaded >= imagesTotal)
			{
				this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_SUCCESS, null, true));
			}
			this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_START, imagesLoaded, true));
			//trace("addToImagesLoaded      imagesLoaded = " + imagesLoaded + " imagesTotal = " + imagesTotal);
		}
		
		private function initLoaderIOError(evt:IOErrorEvent):void
		{
			this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_ERROR, evt.text));
		}
		
		private function initLoaderSecurityError(evt:SecurityErrorEvent):void
		{
			this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_ERROR, evt.text));
		}		
		
		private function initLoaderOnStatus(evt:HTTPStatusEvent):void
		{			
		    if (evt.status != 200 && evt.status != 0) {
		       this.dispatchEvent(new ProjectLoadEvent(ProjectLoadEvent.XML_ERROR, "HTTPStatus Error Status #" + evt.status));
		    }
		}
	}
}