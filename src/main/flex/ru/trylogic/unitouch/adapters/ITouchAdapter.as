package ru.trylogic.unitouch.adapters
{

	public interface ITouchAdapter
	{
		function get target() : *;

		function dispose() : void;

		function get numTouches() : uint;
	}
}