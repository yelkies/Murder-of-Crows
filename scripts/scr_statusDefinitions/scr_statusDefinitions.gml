function Perform_Status_Effects(_status_effects)
{
	struct_foreach(_status_effects, function(_key, _val)
	{
		
		switch (_key)
		{
			case "Fever":
			
				if object_exists(object_index) object_index.Hp -=1;
			break;
			
			//case "Knock":
			//	// if object collides with wall, inflict stun
			//	if (object_index.force_x && object_index.force_y == 0); //remove knock //yipppe
				
			
		}
		
	})
}