package ru.trylogic.unitouch.adapters
{

	import ru.trylogic.unitouch.ITouchListener;

	public interface ITouchAdapter extends ITouchListener
	{
	}
}

import flash.ui.Multitouch;

import ru.trylogic.unitouch.adapters.ITouchAdapter;
import ru.trylogic.unitouch.adapters.native.NativeMouseTouchAdapter;
import ru.trylogic.unitouch.adapters.native.NativeTouchAdapter;
import ru.trylogic.unitouch.adapters.starling.StarlingTouchAdapter;

import tl.adapters.nativeDisplayList.NativeViewContainerAdapter;
import tl.adapters.starling.StarlingViewContainerAdapter;
import tl.factory.ConstructorFactory;

import tl.ioc.IoCHelper;
import tl.view.IViewContainerAdapter;

class StaticConstruct
{
	{
		switch ( IoCHelper.resolve( IViewContainerAdapter ).constructor )
		{
			case NativeViewContainerAdapter:
			{
				if ( Multitouch.supportsTouchEvents )
				{
					IoCHelper.registerType( ITouchAdapter, NativeTouchAdapter, ConstructorFactory );
				}
				else
				{
					IoCHelper.registerType( ITouchAdapter, NativeMouseTouchAdapter, ConstructorFactory );
				}
			}
				break;

			case StarlingViewContainerAdapter:
			{
				IoCHelper.registerType( ITouchAdapter, StarlingTouchAdapter, ConstructorFactory );
			}
				break;
		}
	}
}