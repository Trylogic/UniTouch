package ru.trylogic.unitouch.adapters
{

	public class TouchContext
	{
		private static const pool : Vector.<TouchContext> = new Vector.<TouchContext>();

		internal var _touchPointID : int = -1;

		internal var _target : *;

		internal var _stageX : Number = 0;
		internal var _stageY : Number = 0;

		internal var _beginStageX : Number = 0;
		internal var _beginStageY : Number = 0;

		internal var _dx : Number = 0;
		internal var _dy : Number = 0;

		public static function pop() : TouchContext
		{
			if ( pool.length == 0 )
			{
				return new TouchContext();
			}
			else
			{
				return pool.pop();
			}
		}

		public static function push( touchContext : TouchContext ) : void
		{
			touchContext._touchPointID = -1;

			touchContext._target = null;

			touchContext._stageX = 0;
			touchContext._stageY = 0;

			touchContext._beginStageX = 0;
			touchContext._beginStageY = 0;

			touchContext._dx = 0;
			touchContext._dy = 0;
			pool.push( touchContext );
		}

		public function get touchPointID() : int
		{
			return _touchPointID;
		}

		public function get target() : *
		{
			return _target;
		}

		public function get stageX() : Number
		{
			return _stageX;
		}

		public function get stageY() : Number
		{
			return _stageY;
		}

		public function get beginStageX() : Number
		{
			return _beginStageX;
		}

		public function get beginStageY() : Number
		{
			return _beginStageY;
		}

		public function get dx() : Number
		{
			return _dx;
		}

		public function get dy() : Number
		{
			return _dy;
		}

		public function TouchContext()
		{
		}

		public function toString() : String
		{
			return "[TouchContext forTouchPointID: " + _touchPointID + " and target: " + _target + " ]";
		}
	}
}
