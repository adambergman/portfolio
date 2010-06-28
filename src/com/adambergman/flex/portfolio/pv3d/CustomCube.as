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
	// This class is used for the display of screenshots in 3D Space.  The screenshots
	// are actually very thin Cubes.  A few tweens/display functions have been tacked
	// on to the cube including Fade In/Out, a Glow filter (used on mouse over) and
	// a rotation function that makes the cube rotate based on mouse position.
	
	import caurina.transitions.Tweener;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	
	public class CustomCube extends Cube
	{
		
		public static const MATERIAL_CLICKED_EVENT:String = "mouse_clicked_zoom";
		
		[Bindable] public var title:String = "";
		[Bindable] public var index:Number = 0;
		
		private var _zoomed:Boolean = false;
		
		private var superZ:Number = 0; // variable to hold the initial Z position
		
		public function CustomCube(w:Number, h:Number, bitmapData:Bitmap)
		{	
					
			addEventListener(InteractiveScene3DEvent.OBJECT_OVER, materialOver);
			addEventListener(InteractiveScene3DEvent.OBJECT_OUT, materialOut);
			addEventListener(InteractiveScene3DEvent.OBJECT_CLICK, materialClick);
			addEventListener(InteractiveScene3DEvent.OBJECT_PRESS, materialClick);
			
				
			var material:MaterialObject3D = new BitmapMaterial(bitmapData.bitmapData, true);
			material.smooth = true;
			material.interactive = true;
			
			var ml:MaterialsList = new MaterialsList();
			
			ml.addMaterial(material, 'back');
			ml.addMaterial(new ColorMaterial(0xAEAEAE), 'front');
			ml.addMaterial(new ColorMaterial(0x000000), 'top');
			ml.addMaterial(new ColorMaterial(0x000000), 'right');
			ml.addMaterial(new ColorMaterial(0x000000), 'left');
			ml.addMaterial(new ColorMaterial(0x000000), 'bottom'); 
			
			super(ml, w, 0, h, 6, 6, 6);
			
			useOwnContainer = true;
			superZ = this.z;	
		}
		
		private function materialClick(event:InteractiveScene3DEvent):void
		{
			this.dispatchEvent(new Event(MATERIAL_CLICKED_EVENT, true));
		}
		
		private function materialOver(evt:InteractiveScene3DEvent):void
		{
			createGlow();
		}
		
		private function materialOut(evt:InteractiveScene3DEvent):void
		{
			clearFilters();
		}

		// alpha fading in and out
		
		public function fadeIn():void
		{
			Tweener.addTween(this, {alpha: 1, time: 1.5});
		}
		
		public function fadeOut():void
		{
			Tweener.addTween(this, {alpha: 0.4, time: 1.5});
		}
		
		
		// add a glow to the cube
		public function createGlow():void
		{
			if(_zoomed){ return; } // only glows when not zoomed in 
			
			var glow:GlowFilter = new GlowFilter(0xFFFFFF, 0, 0, 0, 0);
			this.filters.push(glow);				
			Tweener.addTween(glow, {blurX: 25, blurY: 25, strength: 4, alpha: 0.4, time: 0.5});
		}
		
		// remove the glow (and any other filters) on the cube
		public function clearFilters():void
		{
			this.filters = new Array();
		}
		
		// calculates rotation for mouse overs
		public function setRotation(mouseX:Number, mouseY:Number, viewWidth:Number, viewHeight:Number):void
		{
			var rotY: Number = (mouseY-(viewHeight/2))/(viewHeight/2)*(100);
			var rotX: Number = (mouseX-(viewWidth/2))/(viewWidth/2)*(-100);
			this.rotationX = rotX / 10;
			this.rotationY = rotY / 10;
		}
		
		// properties
		public function get zoomed():Boolean
		{
			return _zoomed;
		}
		
		public function set zoomed(v:Boolean):void
		{
			_zoomed = v;
		}
	}
}