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
	
	public class ScreenshotChangedEvent extends Event
	{
		public static const SCREENSHOT_CHANGED:String = "screenshot_changed_event";
		
		public var currentScreenshotIndex:uint;
		public var previousScreenshotIndex:uint;
		
		public function ScreenshotChangedEvent(type:String, currentScreenshotIndex:uint, previousScreenshotIndex:uint, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.previousScreenshotIndex = previousScreenshotIndex;
			this.currentScreenshotIndex = currentScreenshotIndex;
			super(type, bubbles, cancelable);
		}
	}
}