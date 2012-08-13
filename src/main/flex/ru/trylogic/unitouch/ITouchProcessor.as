package ru.trylogic.unitouch
{

	import ru.trylogic.unitouch.gestures.AbstractGestureRecognizer;

	public interface ITouchProcessor extends ITouchListener
	{
		function get target() : *;

		function addGestureRecognizer( gestureRecognizer : AbstractGestureRecognizer ) : void;

		function removeGestureRecognizer( gestureRecognizer : AbstractGestureRecognizer ) : void;
	}
}
