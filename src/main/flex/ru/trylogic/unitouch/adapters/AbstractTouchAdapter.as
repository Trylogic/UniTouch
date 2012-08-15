package ru.trylogic.unitouch.adapters
{

	import ru.trylogic.unitouch.ITouchProcessor;

	public class AbstractTouchAdapter implements ITouchAdapter
	{
		protected var _target : *;

		protected var _touchProcessor : ITouchProcessor;

		protected var _touchContexts : Array = [];

		protected var numTouches : int = 0;

		public function set target( value : * ) : void
		{
			if ( value == _target )
			{
				return;
			}

			if ( _target )
			{
				removeEventListeners();
				for ( var key : String in _touchContexts )
				{
					TouchContext.push( _touchContexts[key] );
				}

				_touchContexts = [];
			}

			_target = value;
			if ( _target )
			{
				addEventListeners();
			}
		}

		public function AbstractTouchAdapter( touchProcessor : ITouchProcessor )
		{
			_touchProcessor = touchProcessor;
		}

		public function addEventListeners() : void
		{
		}

		public function removeEventListeners() : void
		{
		}

		public final function onTouchBegin( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			if ( _touchProcessor )
			{
				var touchContext : TouchContext = getContextByTouchPointID( touchPointID );
				touchContext._beginX = touchContext._localX = localX;
				touchContext._beginY = touchContext._localY = localY;
				touchContext._beginStageX = touchContext._stageX = stageX;
				touchContext._beginStageY = touchContext._stageY = stageY;
				_touchProcessor.onTouchBegin( touchContext );
			}

			numTouches++;
		}

		public final function onTouchMove( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			const touchContext : TouchContext = _touchContexts[touchPointID];
			if ( touchContext == null )
			{
				return;
			}

			if ( _touchProcessor )
			{
				touchContext._localX = localX;
				touchContext._localY = localY;
				touchContext._stageX = stageX;
				touchContext._stageY = stageY;
				_touchProcessor.onTouchMove( touchContext );
			}
		}

		public final function onTouchEnd( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			const touchContext : TouchContext = _touchContexts[touchPointID];
			if ( touchContext == null )
			{
				return;
			}

			if ( _touchProcessor )
			{
				touchContext._localX = localX;
				touchContext._localY = localY;
				touchContext._stageX = stageX;
				touchContext._stageY = stageY;
				_touchProcessor.onTouchEnd( touchContext );
				TouchContext.push( touchContext );
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
