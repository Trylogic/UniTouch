package ru.trylogic.unitouch
{

	import ru.trylogic.unitouch.adapters.ITouchAdapter;
	import ru.trylogic.unitouch.adapters.TouchContext;
	import ru.trylogic.unitouch.gestures.abstract.AbstractGestureRecognizer;

	import tl.ioc.IoCHelper;

	public class UniTouchProcessor implements ITouchProcessor
	{
		protected var touchAdapter : ITouchAdapter;

		protected const gestureRecognizers : Vector.<AbstractGestureRecognizer> = new Vector.<AbstractGestureRecognizer>();

		public function UniTouchProcessor( source : * )
		{
			touchAdapter = IoCHelper.resolve( ITouchAdapter, this );
			touchAdapter.target = source;
		}

		public function onTouchBegin( context : TouchContext ) : void
		{
			for each( var gestureRecognizer : AbstractGestureRecognizer in gestureRecognizers )
			{
				gestureRecognizer.onTouchBegin( context );
			}
		}

		public function onTouchMove( context : TouchContext ) : void
		{
			for each( var gestureRecognizer : AbstractGestureRecognizer in gestureRecognizers )
			{
				gestureRecognizer.onTouchMove( context );
			}
		}

		public function onTouchEnd( context : TouchContext ) : void
		{
			for each( var gestureRecognizer : AbstractGestureRecognizer in gestureRecognizers )
			{
				gestureRecognizer.onTouchEnd( context );
			}
		}

		public function addGestureRecognizer( gestureRecognizer : AbstractGestureRecognizer ) : void
		{
			if ( gestureRecognizers.indexOf( gestureRecognizer ) == -1 )
			{
				// TODO: support for priorities
				gestureRecognizers.push( gestureRecognizer );
			}
		}

		public function removeGestureRecognizer( gestureRecognizer : AbstractGestureRecognizer ) : void
		{
			if ( gestureRecognizers.indexOf( gestureRecognizer ) != -1 )
			{
				gestureRecognizers.splice( gestureRecognizers.indexOf( gestureRecognizer ), 1 );
			}
		}
	}
}
