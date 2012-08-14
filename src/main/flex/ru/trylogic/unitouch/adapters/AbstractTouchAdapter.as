package ru.trylogic.unitouch.adapters
{

	import ru.trylogic.unitouch.ITouchProcessor;
	import ru.trylogic.unitouch.adapters.TouchContext;

	public class AbstractTouchAdapter implements ITouchAdapter
	{
		public const ADD_LISTENERS : uint = 0;
		public const REMOVE_LISTENERS : uint = 1;

		protected var _target : *;

		protected var _touchProcessor : ITouchProcessor;

		protected var _touchContexts : Array = [];

		protected var numTouches : int = 0;

		public function AbstractTouchAdapter( touchProcessor : ITouchProcessor )
		{
			_touchProcessor = touchProcessor;

			_target = touchProcessor.target;

			if ( _target )
			{
				addEventListeners( );
			}
		}

		public function addEventListeners( ) : void
		{
		}

		public function removeEventListeners( ) : void
		{
		}

		public final function onTouchBegin( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if ( _touchProcessor )
			{
				var touchContext : TouchContext = getContextByTouchPointID( touchPointID );
				touchContext._beginX = touchContext._localX = localX;
				touchContext._beginY = touchContext._localY = localY;
				touchContext._stageX = stageX;
				touchContext._stageY = stageY;
				_touchProcessor.onTouchBegin( touchContext );
			}
			numTouches++;
		}

		public final function onTouchMove( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if ( _touchProcessor )
			{
				var touchContext : TouchContext = getContextByTouchPointID(touchPointID);
				touchContext._localX = localX;
				touchContext._localY = localY;
				touchContext._stageX = stageX;
				touchContext._stageY = stageY;
				_touchProcessor.onTouchMove( touchContext );
			}
		}

		public final function onTouchEnd( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if ( _touchProcessor )
			{
				var touchContext : TouchContext = getContextByTouchPointID(touchPointID);
				touchContext._localX = localX;
				touchContext._localY = localY;
				touchContext._stageX = stageX;
				touchContext._stageY = stageY;
				_touchProcessor.onTouchEnd( touchContext );
				TouchContext.push(touchContext);
				delete _touchContexts[touchPointID];
			}
			numTouches--;
		}

		protected function getContextByTouchPointID( touchPointID : int ) : TouchContext
		{
			var touchContext : TouchContext = _touchContexts[touchPointID];

			if ( touchContext == null )
			{
				_touchContexts[touchPointID] = touchContext = TouchContext.pop();
			}

			touchContext._touchPointID = touchPointID;

			return touchContext;
		}
	}
}
