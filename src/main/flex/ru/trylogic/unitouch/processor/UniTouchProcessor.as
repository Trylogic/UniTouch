package ru.trylogic.unitouch.processor
{

	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	import flash.ui.Multitouch;

	import ru.trylogic.unitouch.adapters.ITouchAdapter;
	import ru.trylogic.unitouch.adapters.nativeDisplayList.NativeMouseTouchAdapter;
	import ru.trylogic.unitouch.adapters.nativeDisplayList.NativeTouchAdapter;
	import ru.trylogic.unitouch.adapters.starling.StarlingTouchAdapter;

	public class UniTouchProcessor implements ITouchProcessor
	{
		protected var touchAdapter : ITouchAdapter;

		protected var _touchContexts : Array = [];

		protected var _target : *;

		protected var touchListeners : Vector.<ITouchListener>;

		protected var rawTouchListeners : Vector.<IRawTouchListener>;

		public function get target() : *
		{
			return _target;
		}

		public function get numTouchListeners() : uint
		{
			return touchListeners ? touchListeners.length : 0;
		}

		public function get numRawTouchListeners() : uint
		{
			return rawTouchListeners ? rawTouchListeners.length : 0;
		}

		public function UniTouchProcessor( source : * )
		{
			this._target = source;

			// TODO: remove it
			if ( source is DisplayObject )
			{
				if ( Multitouch.supportsTouchEvents )
				{
					touchAdapter = new NativeTouchAdapter( this );
				}
				else
				{
					touchAdapter = new NativeMouseTouchAdapter( this );
				}
			}
			else if ( ApplicationDomain.currentDomain.hasDefinition( "starling.display.DisplayObject" ) &&
					source is (ApplicationDomain.currentDomain.getDefinition( "starling.display.DisplayObject" ) as Class) )
			{
				touchAdapter = new StarlingTouchAdapter( this );
			}
			else
			{
				throw new Error( "Unsupported target type: " + source.constructor );
			}
		}

		public function addRawTouchListener( listener : IRawTouchListener ) : void
		{
			rawTouchListeners ||= new Vector.<IRawTouchListener>();
			if ( rawTouchListeners.indexOf( listener ) == -1 )
			{
				rawTouchListeners.push( listener );
			}
		}

		public function removeRawTouchListener( listener : IRawTouchListener ) : void
		{
			if ( rawTouchListeners == null )
			{
				return;
			}

			const index : Number = rawTouchListeners.indexOf( listener );

			if ( index != -1 )
			{
				rawTouchListeners.splice( index, 1 );
			}

		}

		public function addTouchListener( touchListener : ITouchListener ) : void
		{
			touchListeners ||= new Vector.<ITouchListener>();
			if ( touchListeners.indexOf( touchListener ) == -1 )
			{
				// TODO: support for priorities
				touchListeners.push( touchListener );
			}
		}

		public function removeTouchListener( touchListener : ITouchListener ) : void
		{
			if ( touchListeners == null )
			{
				return;
			}

			const index : Number = touchListeners.indexOf( touchListener );

			if ( index != -1 )
			{
				touchListeners.splice( index, 1 );
			}

			if ( numTouchListeners == 0 )
			{
				//dispose();
				//delete touchProcessorsByTarget[_target];
			}
		}

		public function dispose() : void
		{
			if ( touchAdapter )
			{
				touchAdapter.dispose();
				touchAdapter = null;
			}
			_touchContexts = null;
			touchListeners.length = 0;
		}

		public function onRawTouchBegin( touchPointID : int, stageX : Number, stageY : Number ) : void
		{
			for each( var rawTouchListener : IRawTouchListener in rawTouchListeners )
			{
				rawTouchListener.onRawTouchBegin( touchPointID, stageX, stageY );
			}

			var touchContext : TouchContext = getContextByTouchPointID( touchPointID );
			touchContext._target = _target;
			touchContext._dx = 0;
			touchContext._dy = 0;
			touchContext._beginStageX = touchContext._stageX = stageX;
			touchContext._beginStageY = touchContext._stageY = stageY;

			for each( var gestureRecognizer : ITouchListener in touchListeners )
			{
				gestureRecognizer.onTouchBegin( touchContext );
			}
		}

		public function onRawTouchMove( touchPointID : int, stageX : Number, stageY : Number ) : void
		{
			for each( var rawTouchListener : IRawTouchListener in rawTouchListeners )
			{
				rawTouchListener.onRawTouchMove( touchPointID, stageX, stageY );
			}

			const touchContext : TouchContext = _touchContexts[touchPointID];
			if ( touchContext == null )
			{
				return;
			}

			touchContext._dx = stageX - touchContext._stageX;
			touchContext._dy = stageY - touchContext._stageY;
			touchContext._stageX = stageX;
			touchContext._stageY = stageY;

			for each( var gestureRecognizer : ITouchListener in touchListeners )
			{
				gestureRecognizer.onTouchMove( touchContext );
			}
		}

		public function onRawTouchEnd( touchPointID : int, stageX : Number, stageY : Number ) : void
		{
			for each( var rawTouchListener : IRawTouchListener in rawTouchListeners )
			{
				rawTouchListener.onRawTouchEnd( touchPointID, stageX, stageY );
			}

			const touchContext : TouchContext = _touchContexts[touchPointID];
			if ( touchContext == null )
			{
				return;
			}

			touchContext._dx = stageX - touchContext._stageX;
			touchContext._dy = stageY - touchContext._stageY;
			touchContext._stageX = stageX;
			touchContext._stageY = stageY;

			for each( var gestureRecognizer : ITouchListener in touchListeners )
			{
				gestureRecognizer.onTouchEnd( touchContext );
			}

			TouchContext.push( touchContext );
			delete _touchContexts[touchPointID];

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
