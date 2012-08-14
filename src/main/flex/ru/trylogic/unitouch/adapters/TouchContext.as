package ru.trylogic.unitouch.adapters
{

	public class TouchContext
	{
		private static const pool : Vector.<TouchContext> = new Vector.<TouchContext>();

		internal var _touchPointID : int = -1;

		internal var _target : *;

		internal var _localX : Number = 0;
		internal var _localY : Number = 0;

		internal var _stageX : Number = 0;
		internal var _stageY : Number = 0;

		internal var _beginX : Number = 0;
		internal var _beginY : Number = 0;

		public static function pop() : TouchContext
		{
			if(pool.length == 0)
			{
				return new TouchContext();
			}
			else
			{
				return pool.pop();
			}
		}

		public static function push(touchContext : TouchContext) : void
		{
			touchContext._touchPointID = -1;

			touchContext._target = null;

			touchContext._localX = 0;
			touchContext._localY = 0;

			touchContext._stageX = 0;
			touchContext._stageY = 0;

			touchContext._beginX = 0;
			touchContext._beginY = 0;
			pool.push(touchContext);
		}

		public function TouchContext( )
		{
		}

		public function get touchPointID() : int
		{
			return _touchPointID;
		}

		public function get target() : *
		{
			return _target;
		}

		public function get localX() : Number
		{
			return _localX;
		}

		public function get localY() : Number
		{
			return _localY;
		}

		public function get stageX() : Number
		{
			return _stageX;
		}

		public function get stageY() : Number
		{
			return _stageY;
		}

		public function get beginX() : Number
		{
			return _beginX;
		}

		public function get beginY() : Number
		{
			return _beginY;
		}
	}
}
