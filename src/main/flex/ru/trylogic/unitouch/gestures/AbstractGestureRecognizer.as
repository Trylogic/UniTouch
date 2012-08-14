package ru.trylogic.unitouch.gestures
{

	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import ru.trylogic.unitouch.ITouchListener;
	import ru.trylogic.unitouch.ITouchProcessor;
	import ru.trylogic.unitouch.UniTouchProcessor;
	import ru.trylogic.unitouch.adapters.TouchContext;

	public class AbstractGestureRecognizer extends EventDispatcher implements ITouchListener
	{
		protected static const touchProcessorsByTarget : Dictionary = new Dictionary( true );
		protected var _target : *;

		public function set target( value : * ) : void
		{
			if ( value == _target )
			{
				return;
			}

			var touchProcessor : ITouchProcessor;

			if ( _target )
			{
				touchProcessor = touchProcessorsByTarget[_target];
				if ( touchProcessor )
				{
					touchProcessor.removeGestureRecognizer( this );
				}
			}

			_target = value;

			if ( _target )
			{
				touchProcessor = touchProcessorsByTarget[_target];
				if ( !touchProcessor )
				{
					touchProcessorsByTarget[_target] = touchProcessor = new UniTouchProcessor( _target );
				}

				touchProcessor.addGestureRecognizer( this );
			}
		}

		public function AbstractGestureRecognizer()
		{
		}

		public function onTouchBegin( context : TouchContext ) : void
		{
		}

		public function onTouchMove( context : TouchContext ) : void
		{
		}

		public function onTouchEnd( context : TouchContext ) : void
		{
		}

		protected function onTouchCancel() : void
		{

		}
	}
}
