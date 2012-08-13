package ru.trylogic.unitouch.gestures
{

	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import ru.trylogic.unitouch.ITouchListener;
	import ru.trylogic.unitouch.ITouchProcessor;
	import ru.trylogic.unitouch.UniTouchProcessor;

	public class AbstractGestureRecognizer extends EventDispatcher implements ITouchListener
	{
		protected static const touchProcessorsByTarget : Dictionary = new Dictionary( true );
		protected var _source : *;

		protected var _listener : Function;

		public function set source( value : * ) : void
		{
			if ( value == _source )
			{
				return;
			}

			_source = value;

			if ( _source )
			{
				var touchProcessor : ITouchProcessor = touchProcessorsByTarget[_source];
				if ( !touchProcessor )
				{
					touchProcessorsByTarget[_source] = touchProcessor = new UniTouchProcessor( _source );
				}

				touchProcessor.addGestureRecognizer( this );
			}
		}

		public function AbstractGestureRecognizer()
		{
		}

		public function onTouchBegin( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
		}

		public function onTouchMove( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
		}

		public function onTouchEnd( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
		}

		protected function cancel() : void
		{

		}
	}
}
