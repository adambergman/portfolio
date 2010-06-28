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

package com.adambergman.flex.portfolio.events
{
	import com.adambergman.flex.portfolio.Project;
	
	import flash.events.Event;
	
	// This event is dispatched every time Model.currentProject or Model.currentProjectIndex is changed
	public class ProjectChangedEvent extends Event
	{
		public static const PROJECT_CHANGED:String = "project_changed_event";
		
		public var project:Project;
		
		public function ProjectChangedEvent(type:String, project:Project, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.project = project;
		}
	}
}