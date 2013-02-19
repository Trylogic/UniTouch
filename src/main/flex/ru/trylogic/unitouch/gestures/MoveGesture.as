package ru.trylogic.unitouch.gestures
{

	import flash.system.Capabilities;

	import ru.trylogic.unitouch.processor.TouchContext;
	import ru.trylogic.unitouch.gestures.abstractGesture.AbstractGestureRecognizer;
	import ru.trylogic.unitouch.gestures.abstractGesture.states.GestureState;
	import ru.trylogic.unitouch.gestures.abstractGesture.states.GestureStates;

	public class MoveGesture extends AbstractGestureRecognizer
	{
		protected var _slop : uint = 4 * Math.round( 20 / 252 * flash.system.Capabilities.screenDPI );
		private var _slopInSquare : uint = _slop * _slop;

		protected var _currentTouchContext : TouchContext;

		public function get slop() : uint
		{
			return _slop;
		}

		public function set slop( value : uint ) : void
		{
			if ( _slop == value )
			{
				return;
			}

			_slop = value;
			_slopInSquare = _slop * _slop;
		}

		public function get currentTouchContext() : TouchContext
		{
			return _currentTouchContext;
		}

		public function MoveGesture()
		{
		}

		protected function checkSlop( context : TouchContext ) : Boolean
		{
			if ( _slop == 0 )
			{
				return true;
			}

			const dx : Number = context.beginStageX - context.stageX;
			const dy : Number = context.beginStageY - context.stageY;

			if ( _slop == 1 && (dx == 1 || dy == 1) )
			{
				return true;
			}

			return ( dx * dx + dy * dy ) > _slopInSquare;
		}

		override protected function internalOnTouchBegin( context : TouchContext ) : void
		{
			if ( _currentTouchContext == null )
			{
				_currentTouchContext = context;
				setState( GestureStates.POSSIBLE );
			}
			else
			{
				setState( GestureStates.FAILED );
			}
		}

		override protected function internalOnTouchMove( context : TouchContext ) : void
		{
			if ( context == _currentTouchContext )
			{
				if ( currentState == GestureStates.CHANGED || currentState == GestureStates.BEGAN )
				{
					setState( GestureStates.CHANGED );
				}
				else
				{
					if ( checkSlop( context ) )
					{
						setState( GestureStates.BEGAN );
					}
				}
			}
		}

		override protected function internalOnTouchEnd( context : TouchContext ) : void
		{
			if ( context == _currentTouchContext )
			{
				if ( currentState == GestureStates.POSSIBLE )
				{
					setState( GestureStates.FAILED );
				}
				else
				{
					setState( GestureStates.RECOGNIZED );
				}
			}
		}

		override protected function stateChanged( oldState : GestureState, newState : GestureState ) : void
		{
			super.stateChanged( oldState, newState );

			if ( isGestureIsOver() )
			{
				_currentTouchContext = null;
			}
		}
	}
}
