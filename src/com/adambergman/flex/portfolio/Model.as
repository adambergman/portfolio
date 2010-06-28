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
	import com.adambergman.flex.portfolio.events.ProjectChangedEvent;
	import com.adambergman.flex.portfolio.events.ProjectLoadEvent;
	import com.adambergman.flex.portfolio.events.ScreenshotChangedEvent;
	
	import flash.events.Event;
	
	import flash.events.EventDispatcher;

	[Bindable]
	public class Model extends EventDispatcher
	{
		private static const _instance:Model = new Model( SingletonEnforcer );

		// event constants
		public static const ZOOM_CHANGED_EVENT:String = "zoom_screenshot_changed_event";
		
		// project xml loader and project collection
		public var projectData:ProjectLoader;
		
		// variables for screenshots
		private var _currentScreenshotIndex:uint = 0;
		private var _screenshotTitleText:String = "";
		private var _isZoomed:Boolean = false;
		public var totalScreenshots:uint = 0;
		public var stopScreenshotRotation:Boolean = false;
		public var fadeScreenshotsOnMouseOver:Boolean = true;
		
		
		// private vars for properties		
		private var _currentProject:Project;
		private var _currentProjectIndex:uint = 0; 
		
		// Model constructor.  This enforces a singleton, you should not access
		// this class by using new Model() you should instead set a new variable
		// to Model.instance like so:
		// 		private var model:Model = Model.instance;
		// 
		public function Model(enforcer:Class)
		{
			if(enforcer != SingletonEnforcer)
			{
				throw new Error("The Model class is a Singleton.  It should not be initialized but accessed directly using 'Model.instance'");
			}
			
			projectData = new ProjectLoader();
		}
		
		
		// static function to return our singleton instance
		public static function get instance():Model  
		{  
			return _instance;  
		}  
		
		// should be called one time to start the loading of the xml and images
		public function loadProjects():void
		{
			projectData.addEventListener(ProjectLoadEvent.XML_ERROR, loadedError);
			projectData.load("projects.xml");
		}
		
		// handles errors during image/xml loading
		private function loadedError(event:ProjectLoadEvent):void
		{
			throw new Error("Error loading XML project data. " + event.data);
		}

		
		// moves to the next project in the collection
		public function nextProject():void
		{
			currentProjectIndex++;
		}
		
		// moves to the previous project in the collection
		public function previousProject():void
		{
			currentProjectIndex--;
		}
		
		public function nextScreenshot():void
		{
			currentScreenshotIndex++;
			//gotoPlaneIndex(currentScreenshotIndex, prevIndex);	
		}
		
		public function previousScreenshot():void
		{
			currentScreenshotIndex--;	
		}
		
				
		// properties getters/setters
		public function get currentProjectIndex():uint
		{
			return _currentProjectIndex;
		}
		public function set currentProjectIndex(value:uint):void
		{
			if(value >= projectData.projects.length)
			{
				value = 0;
			}
			if(value <= -1)
			{
				value = projectData.projects.length - 1;
			}
			_currentProjectIndex = value;
			// set the currentProject to the proper index
			currentProject = Project(projectData.projects.getItemAt(_currentProjectIndex));
		}
		
		public function get currentProject():Project
		{
			return _currentProject;
		}
		public function set currentProject(value:Project):void
		{
			_currentProject = value;
			dispatchEvent(new ProjectChangedEvent(ProjectChangedEvent.PROJECT_CHANGED, currentProject));
		}
		
		public function get currentScreenshotIndex():uint
		{
			return _currentScreenshotIndex;
		}
		public function set currentScreenshotIndex(value:uint):void
		{
			var prevIndex:uint = _currentScreenshotIndex;
			if(value < 0)
			{
				value = totalScreenshots - 1;
			}	
			if(value >= totalScreenshots)
			{
				value = 0;
			}
			_currentScreenshotIndex = value;
			dispatchEvent(new ScreenshotChangedEvent(ScreenshotChangedEvent.SCREENSHOT_CHANGED, currentScreenshotIndex, prevIndex));
		}

		public function get screenshotTitleText():String
		{
			return _screenshotTitleText;
		}

		public function set screenshotTitleText(value:String):void
		{
			_screenshotTitleText = value;
		}

		public function get isZoomed():Boolean
		{
			return _isZoomed;
		}

		public function set isZoomed(value:Boolean):void
		{
			_isZoomed = value;
			dispatchEvent(new Event(ZOOM_CHANGED_EVENT));
		}


	}
}

class SingletonEnforcer {}