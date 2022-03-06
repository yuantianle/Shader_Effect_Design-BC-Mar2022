#version 330 compatibility
#extension GL_EXT_gpu_shader4: enable 
#extension GL_EXT_geometry_shader4: enable 

layout( triangles_adjacency ) in;
layout( triangle_strip, max_vertices=200 ) out;

uniform float uLightX, uLightY, uLightZ;

vec3 eyeLightPosition = vec3(uLightX, uLightY, uLightZ);

//out float vXg, vY;
//flat out vec3 vNf;
//out vec3 vNs;
//flat out vec3 vLf;
//out vec3 vLs;
//flat out vec3 vEf;
//out vec3 vEs;

out vec4 gColor;

void main( ) {
	vec3 V0 = gl_PositionIn[0].xyz; 
	vec3 V1 = gl_PositionIn[1].xyz; 
	vec3 V2 = gl_PositionIn[2].xyz; 
	vec3 V3 = gl_PositionIn[3].xyz; 
	vec3 V4 = gl_PositionIn[4].xyz; 
	vec3 V5 = gl_PositionIn[5].xyz;
	
	vec3 N042 = cross( V4-V0, V2-V0 );
	vec3 N021 = cross( V2-V0, V1-V0 ); 
	vec3 N243 = cross( V4-V2, V3-V2 ); 
	vec3 N405 = cross( V0-V4, V5-V4 );
	
	if( dot( N042, N021 ) < 0. ) 		// make sure each outer triangle’s
		N021 = vec3(0.,0.,0.) - N021; 	// normal is in the same general direction
	if( dot( N042, N243 ) < 0. ) 
		N243 = vec3(0.,0.,0.) - N243;
	if( dot( N042, N405 ) < 0. ) 
		N405 = vec3(0.,0.,0.) - N405;
	
	vec3 LightRay = eyeLightPosition - (V0+V2+V4)/3.;

	if( dot (N042, LightRay) <= -0.5 ) 
	{
		gl_Position = gl_ProjectionMatrix* vec4( V0, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V2, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V4, 1. ); 
		EmitVertex( ); 
		gColor = vec4 (0,0,0,1);
		EndPrimitive( );
	}
	else
	{
		gl_Position = gl_ProjectionMatrix* vec4( V0, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V2, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V4, 1. ); 
		EmitVertex( ); 
		gColor = vec4 (1,0,0,1);
		EndPrimitive( );
	}

	if( dot (N021, LightRay) <= -0.5 )
	{
		gl_Position = gl_ProjectionMatrix* vec4( V0, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V2, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V1, 1. ); 
		EmitVertex( ); 
		gColor = vec4 (0,0,0,1);
		EndPrimitive( );
	}
	else
	{
		gl_Position = gl_ProjectionMatrix* vec4( V0, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V2, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V1, 1. ); 
		EmitVertex( ); 
		gColor = vec4 (1,0,0,1);
		EndPrimitive( );
	}
	
	if( dot (N243, LightRay) <= -0.5 )
	{
		gl_Position = gl_ProjectionMatrix* vec4( V2, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V4, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V3, 1. ); 
		EmitVertex( ); 
		gColor = vec4 (0,0,0,1);
		EndPrimitive( );
	}
	else
	{
		gl_Position = gl_ProjectionMatrix* vec4( V2, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V4, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V3, 1. ); 
		EmitVertex( ); 
		gColor = vec4 (1,0,0,1);
		EndPrimitive( );
	}
	
	if( dot (N405, LightRay) <= -0.5 )
	{
		gl_Position = gl_ProjectionMatrix* vec4( V4, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V0, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V5, 1. ); 
		EmitVertex( ); 
		gColor = vec4 (0,0,0,1);
		EndPrimitive( );
	}
	else
	{
		gl_Position = gl_ProjectionMatrix* vec4( V4, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V0, 1. ); 
		EmitVertex( ); 
		gl_Position = gl_ProjectionMatrix* vec4( V5, 1. ); 
		EmitVertex( ); 
		gColor = vec4 (1,0,0,1);
		EndPrimitive( );
	}

	//if( N042.z * N243.z <= 0. ) {
	//	gl_Position = gl_ProjectionMatrix* vec4( V2, 1. ); 
	//	EmitVertex( ); 	 
	//	gl_Position = gl_ProjectionMatrix* vec4( V4, 1. ); 
	//	EmitVertex( ); 
	//	EndPrimitive( );
	//}
	//if( N042.z * N405.z <= 0. ) {
	//	gl_Position = gl_ProjectionMatrix* vec4( V4, 1. ); 
	//	EmitVertex( ); 
	//	gl_Position = gl_ProjectionMatrix* vec4( V0, 1. ); 
	//	EmitVertex( ); 
	//	EndPrimitive( );
	//} 
}