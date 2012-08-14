package ru.trylogic.unitouch
{

	import ru.trylogic.unitouch.adapters.TouchContext;

	public interface ITouchListener
	{
		function onTouchBegin( context : TouchContext ) : void;
		function onTouchMove( context : TouchContext ) : void;
		function onTouchEnd( context : TouchContext ) : void;
	}
}
