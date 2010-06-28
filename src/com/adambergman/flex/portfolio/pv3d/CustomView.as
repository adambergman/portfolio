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

package com.adambergman.flex.portfolio.pv3d
{
	import caurina.transitions.Tweener;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.view.BasicView;
	
	
	// This class is the PaperVision3D viewport that is rendered on
	// a UIComponent (3dView.mxml).  
	
	public class CustomView extends BasicView
	{
		
		// These variables are usd to keep track of the 
		// start position of our camera object
		private var originX:Number = 0;
		private var originY:Number = 0;
		private var originZ:Number = 0;
		
		
		// Constructor.  Sets focus/zoom and saves origin information
		public function CustomView(viewportWidth:Number=1024, viewportHeight:Number=768, scaleToStage:Boolean=true, interactive:Boolean=true)
		{
			super(viewportWidth, viewportHeight, scaleToStage, interactive, CameraType.FREE);
			camera.focus = 100;
			camera.zoom = 10;
		   	startRendering();
			originX = camera.x;
			originY = camera.y;
			originZ = camera.z;
			buttonMode = true;
			moveToOrigin();		
			startRendering();
		}
		
		/////////////////////////////////////////////////////
		// Camera Movement Functions
		/////////////////////////////////////////////////////
		
		// Move the camera to a specific set of coords
		public function cameraTween(x:Number, y:Number, z:Number, time:Number = 1):void
		{
			Tweener.removeTweens(camera);
			Tweener.addTween(camera, {time: time, x: x, y: y, z: z});
		}
		
		// Move the camera to the stored origin points
		public function moveToOrigin():void
		{
			cameraTween(originX, originY, originZ);
		}
	}
}