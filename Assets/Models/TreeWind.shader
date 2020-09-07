// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TreeWind"
{
	Properties
	{
		_Frequency("Frequency", Range( 0 , 1)) = 0
		_WindDirection("WindDirection ", Range( 0 , 6.25)) = 0
		_Benamount("Benamount", Range( 0 , 1)) = 0
		_Speed("Speed", Range( 0 , 2)) = 0.6192986
		_Float20("Float 20", Float) = -1
		_RotaBlend("RotaBlend", Range( 0 , 1)) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _WindDirection;
		uniform float _Float20;
		uniform float _RotaBlend;
		uniform float _Frequency;
		uniform float _Speed;
		uniform float _Benamount;


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 normalizeResult8_g39 = normalize( ( (float4( unity_ObjectToWorld[0][3],unity_ObjectToWorld[1][3],unity_ObjectToWorld[2][3],unity_ObjectToWorld[3][3] )).xyz - float3(2,0,2) ) );
			float3 break11_g39 = normalizeResult8_g39;
			float temp_output_24_0_g39 = ( atan2( break11_g39.z , break11_g39.x ) + _Float20 );
			float temp_output_37_0 = temp_output_24_0_g39;
			float lerpResult39 = lerp( _WindDirection , temp_output_37_0 , _RotaBlend);
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_7_0 = ( ( ( ase_worldPos.x + ase_worldPos.z ) * _Frequency ) + ( _Time.y * _Speed ) );
			float temp_output_9_0 = cos( temp_output_7_0 );
			float temp_output_10_0 = ( ase_vertex3Pos.y * ( temp_output_9_0 + sin( ( temp_output_7_0 + 1.0 ) ) ) );
			float temp_output_11_0 = ( temp_output_10_0 * _Benamount );
			float4 appendResult13 = (float4(temp_output_11_0 , 0.0 , temp_output_11_0 , 0.0));
			float4 break16 = mul( appendResult13, unity_ObjectToWorld );
			float4 appendResult19 = (float4(break16.x , 0 , break16.z , 0.0));
			float3 rotatedValue20 = RotateAroundAxis( float3( 0,0,0 ), appendResult19.xyz, normalize( float3( 0,-1,0 ) ), lerpResult39 );
			v.vertex.xyz += rotatedValue20;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color1 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			o.Albedo = color1.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18400
965;75;1594;765;648.7275;-160.1359;1.243907;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;2;-1478.011,61.73331;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-1265.337,81.85356;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1465.062,497.4745;Inherit;False;Property;_Speed;Speed;3;0;Create;True;0;0;False;0;False;0.6192986;1.5;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;8;-1399.317,343.9609;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1572.883,240.8458;Inherit;False;Property;_Frequency;Frequency;0;0;Create;True;0;0;False;0;False;0;0.17;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1141.048,194.5994;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1178.274,456.3152;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-1027.248,321.1635;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-1025.182,576.2532;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;9;-799.7183,289.8022;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;34;-872.1821,574.2532;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-746.1821,366.2532;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;4;-813.4502,111.9134;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-475.1612,542.7229;Inherit;False;Property;_Benamount;Benamount;2;0;Create;True;0;0;False;0;False;0;0.04;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-522.1865,284.9016;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-258.0064,282.4971;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-87.55688,253.7219;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;15;-122.267,504.973;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;78.31286,257.1452;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-56.56665,686.4523;Inherit;False;Property;_Float20;Float 20;4;0;Create;True;0;0;False;0;False;-1;-0.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;18;173.4897,104.2877;Inherit;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;16;296.3097,303.2691;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;40;113.162,855.241;Inherit;False;Property;_RotaBlend;RotaBlend;6;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;37;129.6512,698.2463;Inherit;False;OrientationBasedSprite 2;-1;;39;5a23f872a4d0444948f58f0e1e2b7935;0;1;48;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;35.88403,589.9249;Inherit;False;Property;_WindDirection;WindDirection ;1;0;Create;True;0;0;False;0;False;0;4.173212;0;6.25;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;19;517.0344,170.4678;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;39;460.298,630.5378;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;30;-617.3203,465.1898;Inherit;True;0;0;1;0;8;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;1.17;False;2;FLOAT;9.76;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.RotateAboutAxisNode;20;697.293,313.6506;Inherit;False;True;4;0;FLOAT3;0,-1,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;32;-366.1821,121.2532;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.61;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;38;347.2544,468.9252;Inherit;False;Property;_GlobalSentered;Global/Sentered;5;0;Create;True;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;940.722,-78.82236;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;22;-588.5876,-28.87227;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-488.1821,104.2532;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-304.2446,-142.0074;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-454.1424,-32.89262;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;-200.7094,-5.435313;Inherit;True;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1209.355,-84.92165;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;TreeWind;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;1
WireConnection;3;1;2;3
WireConnection;6;0;3;0
WireConnection;6;1;5;0
WireConnection;28;0;8;2
WireConnection;28;1;26;0
WireConnection;7;0;6;0
WireConnection;7;1;28;0
WireConnection;33;0;7;0
WireConnection;9;0;7;0
WireConnection;34;0;33;0
WireConnection;35;0;9;0
WireConnection;35;1;34;0
WireConnection;10;0;4;2
WireConnection;10;1;35;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;13;0;11;0
WireConnection;13;2;11;0
WireConnection;14;0;13;0
WireConnection;14;1;15;0
WireConnection;16;0;14;0
WireConnection;37;48;36;0
WireConnection;19;0;16;0
WireConnection;19;1;18;2
WireConnection;19;2;16;2
WireConnection;39;0;21;0
WireConnection;39;1;37;0
WireConnection;39;2;40;0
WireConnection;20;1;39;0
WireConnection;20;3;19;0
WireConnection;32;0;31;0
WireConnection;38;1;21;0
WireConnection;38;0;37;0
WireConnection;22;0;9;0
WireConnection;31;0;10;0
WireConnection;31;1;30;0
WireConnection;24;0;23;0
WireConnection;24;1;23;0
WireConnection;23;1;22;0
WireConnection;25;0;24;0
WireConnection;25;1;23;0
WireConnection;0;0;1;0
WireConnection;0;11;20;0
ASEEND*/
//CHKSM=A686EA969CE5064B367AD81274FAB2D5AAFA7AB9