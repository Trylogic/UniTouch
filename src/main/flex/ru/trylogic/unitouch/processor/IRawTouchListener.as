package ru.trylogic.unitouch.processor
{

	public interface IRawTouchListener
	{
		function onRawTouchBegin( touchPointID : int, stageX : Number, stageY : Number ) : void;

		function onRawTouchMove( touchPointID : int, stageX : Number, stageY : Number ) : void;

		function onRawTouchEnd( touchPointID : int, stageX : Number, stageY : Number ) : void;
	}
}
