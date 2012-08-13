package ru.trylogic.unitouch.adapters
{

	import ru.trylogic.unitouch.ITouchProcessor;

	public class AbstractTouchAdapter implements ITouchAdapter
	{
		public const ADD_LISTENERS : uint = 0;
		public const REMOVE_LISTENERS : uint = 1;

		protected var _target : *;

		protected var _touchProcessor : ITouchProcessor;

		public function AbstractTouchAdapter( touchProcessor : ITouchProcessor )
		{
			_touchProcessor = touchProcessor;

			_target = touchProcessor.target;

			if ( _target )
			{
				processEventListeners( ADD_LISTENERS );
			}
		}

		public function processEventListeners( action : uint ) : void
		{
			throw new Error( "Abstract method call!" );
		}

		public final function onTouchBegin( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if ( _touchProcessor )
			{
				_touchProcessor.onTouchBegin( touchPointID, localX, localY, stageX, stageY );
			}
		}

		public final function onTouchMove( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if ( _touchProcessor )
			{
				_touchProcessor.onTouchMove( touchPointID, localX, localY, stageX, stageY );
			}
		}

		public final function onTouchEnd( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if ( _touchProcessor )
			{
				_touchProcessor.onTouchEnd( touchPointID, localX, localY, stageX, stageY );
			}
		}
	}
}
