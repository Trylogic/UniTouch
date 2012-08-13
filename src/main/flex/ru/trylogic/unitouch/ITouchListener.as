package ru.trylogic.unitouch
{

	public interface ITouchListener
	{
		function onTouchBegin( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void;
		function onTouchMove( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void;
		function onTouchEnd( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void;
	}
}
