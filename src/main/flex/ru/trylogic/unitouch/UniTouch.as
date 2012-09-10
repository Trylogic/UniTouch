package ru.trylogic.unitouch
{

	import flash.display.Stage;
	import flash.utils.Dictionary;

	import ru.trylogic.unitouch.processor.ITouchProcessor;
	import ru.trylogic.unitouch.processor.UniTouchProcessor;

	public class UniTouch
	{
		protected static const touchProcessorsByTarget : Dictionary = new Dictionary( true );
		public static var stage : Stage;

		public function UniTouch()
		{
		}

		public static function getTouchProcessor( target : * ) : ITouchProcessor
		{
			var processor : ITouchProcessor = touchProcessorsByTarget[target];
			if ( processor == null )
			{
				touchProcessorsByTarget[target] = processor = new UniTouchProcessor( target );
			}

			return processor;
		}
	}
}
