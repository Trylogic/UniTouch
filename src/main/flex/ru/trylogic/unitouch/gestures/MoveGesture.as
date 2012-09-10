package ru.trylogic.unitouch.gestures
{

	import flash.system.Capabilities;

	import ru.trylogic.unitouch.processor.TouchContext;
	import ru.trylogic.unitouch.gestures.abstract.AbstractGestureRecognizer;
	import ru.trylogic.unitouch.gestures.abstract.states.GestureState;
	import ru.trylogic.unitouch.gestures.abstract.states.GestureStates;

	public class MoveGesture extends AbstractGestureRecognizer
	{
		public var slop : uint = 4 * Math.round( 20 / 252 * flash.system.Capabilities.screenDPI );

		protected var _currentTouchContext : TouchContext;

		public function get currentTouchContext() : TouchContext
		{
			return _currentTouchContext;
		}

		public function MoveGesture()
		{
		}

		protected function calculateDistance( context : TouchContext ) : Number
		{
			const dx : Number = context.beginStageX - context.stageX;
			const dy : Number = context.beginStageY - context.stageY;

			return Math.sqrt( dx * dx + dy * dy );
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
					if ( slop == 0 || calculateDistance( context ) > slop )
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
