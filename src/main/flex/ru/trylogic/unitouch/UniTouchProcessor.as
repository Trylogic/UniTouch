package ru.trylogic.unitouch
{

	import ru.trylogic.unitouch.adapters.ITouchAdapter;
	import ru.trylogic.unitouch.gestures.AbstractGestureRecognizer;

	import tl.ioc.IoCHelper;

	public class UniTouchProcessor implements ITouchProcessor
	{
		protected var touchAdapter : ITouchAdapter;

		protected const gestureRecognizers : Vector.<AbstractGestureRecognizer> = new Vector.<AbstractGestureRecognizer>();

		private var _target : *;

		public function get target() : *
		{
			return _target;
		}

		public function UniTouchProcessor(source : *)
		{
			_target = source;
			touchAdapter = IoCHelper.resolve(ITouchAdapter, this);
		}

		public function onTouchBegin( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			for each(var gestureRecognizer : AbstractGestureRecognizer in gestureRecognizers)
			{
				gestureRecognizer.onTouchBegin( touchPointID, localX, localY, stageX, stageY );
			}
		}

		public function onTouchMove( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			for each(var gestureRecognizer : AbstractGestureRecognizer in gestureRecognizers)
			{
				gestureRecognizer.onTouchMove( touchPointID, localX, localY, stageX, stageY );
			}
		}

		public function onTouchEnd( touchPointID : int, localX : Number, localY : Number, stageX : Number, stageY : Number ) : void
		{
			for each(var gestureRecognizer : AbstractGestureRecognizer in gestureRecognizers)
			{
				gestureRecognizer.onTouchEnd( touchPointID, localX, localY, stageX, stageY );
			}
		}

		public function addGestureRecognizer( gestureRecognizer : AbstractGestureRecognizer ) : void
		{
			if(gestureRecognizers.indexOf(gestureRecognizer) == -1)
			{
				// TODO: support for priorities
				gestureRecognizers.push(gestureRecognizer);
			}
		}

		public function removeGestureRecognizer( gestureRecognizer : AbstractGestureRecognizer ) : void
		{
			if(gestureRecognizers.indexOf(gestureRecognizer) != -1)
			{
				gestureRecognizers.splice(gestureRecognizers.indexOf(gestureRecognizer), 1);
			}
		}
	}
}
