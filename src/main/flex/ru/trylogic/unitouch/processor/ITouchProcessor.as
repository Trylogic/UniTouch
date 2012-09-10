package ru.trylogic.unitouch.processor
{


	public interface ITouchProcessor extends IRawTouchListener
	{
		function get target() : *;

		function addTouchListener( touchListener : ITouchListener ) : void;

		function removeTouchListener( touchListener : ITouchListener ) : void;

		function get numTouchListeners() : uint;

		function addRawTouchListener( listener : IRawTouchListener ) : void;

		function removeRawTouchListener( listener : IRawTouchListener ) : void;

		function get numRawTouchListeners() : uint;

		function dispose() : void;
	}
}
