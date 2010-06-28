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
	import flash.events.Event;
	
	public class ProjectLoadEvent extends Event
	{

		public static const XML_SUCCESS:String = "success";
		public static const XML_ERROR:String = "error";
		public static const XML_START:String = "start";
		
		public var data:Object;
		
		public function ProjectLoadEvent(type:String, data:Object, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			switch(type)
			{
				default:					
					this.data = data;	
				break;
			}
			super(type, bubbles, cancelable);									
		}
						
		public override function clone():Event
	    {
	    	return new ProjectLoadEvent( type, data, bubbles, cancelable );
	    }
	}
}