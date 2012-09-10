package ru.trylogic.unitouch.processor
{

	public interface ITouchListener
	{
		function onTouchBegin( context : TouchContext ) : void;

		function onTouchMove( context : TouchContext ) : void;

		function onTouchEnd( context : TouchContext ) : void;
	}
}
