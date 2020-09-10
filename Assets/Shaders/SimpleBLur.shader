// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SimpleBLur"
{
	Properties
	{
		_Float0("Float 0", Range( 0 , 0.2)) = 0
		_AbsorbtionCOlor("AbsorbtionCOlor", Color) = (1,0,0,0)
		_AbsorDistance("AbsorDistance", Float) = -1.62
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
			float3 worldPos;
		};

		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _AbsorDistance;
		uniform float4 _AbsorbtionCOlor;
		uniform float _Float0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float4 __screenPosition6 = ase_screenPosNorm;
			float4 screenColor30 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,__screenPosition6.xy);
			float screenDepth78 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth78 = abs( ( screenDepth78 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _AbsorDistance ) );
			float4 clampResult148 = clamp( ( distanceDepth78 * _AbsorbtionCOlor ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float4 AbsorbtionColor84 = clampResult148;
			float __screenPosU13 = ase_screenPosNorm.x;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float __offset9 = ( _Float0 / distance( ase_vertex3Pos , _WorldSpaceCameraPos ) );
			float __screenPosV14 = ase_screenPosNorm.y;
			float2 appendResult18 = (float2(( __screenPosU13 + __offset9 ) , __screenPosV14));
			float4 screenColor20 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,appendResult18);
			float2 appendResult25 = (float2(__screenPosU13 , ( __screenPosV14 + __offset9 )));
			float4 screenColor27 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,appendResult25);
			float2 appendResult38 = (float2(( __screenPosU13 - __offset9 ) , __screenPosV14));
			float4 screenColor40 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,appendResult38);
			float2 appendResult39 = (float2(__screenPosU13 , ( __screenPosV14 - __offset9 )));
			float4 screenColor41 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,appendResult39);
			float4 screenColor50 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( __screenPosition6 + __offset9 ).xy);
			float4 temp_cast_2 = (__offset9).xxxx;
			float4 screenColor51 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( __screenPosition6 - temp_cast_2 ).xy);
			float2 appendResult57 = (float2(( __screenPosU13 + __offset9 ) , ( __screenPosV14 - __offset9 )));
			float4 screenColor58 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,appendResult57);
			float2 appendResult64 = (float2(( __screenPosU13 - __offset9 ) , ( __screenPosV14 + __offset9 )));
			float4 screenColor65 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,appendResult64);
			o.Emission = ( ( ( screenColor30 * AbsorbtionColor84 ) + ( screenColor20 * AbsorbtionColor84 ) + ( screenColor27 * AbsorbtionColor84 ) + ( screenColor40 * AbsorbtionColor84 ) + ( screenColor41 * AbsorbtionColor84 ) + ( screenColor50 * AbsorbtionColor84 ) + ( screenColor51 * AbsorbtionColor84 ) + ( screenColor58 * AbsorbtionColor84 ) + ( screenColor65 * AbsorbtionColor84 ) ) / 9.0 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18400
981;75;1578;848;4360.896;1330.976;3.223502;True;False
Node;AmplifyShaderEditor.WorldSpaceCameraPos;74;-2391.198,650.4406;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;66;-2196.039,462.3773;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;71;-2002.15,519.6379;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2153.724,358.6859;Inherit;False;Property;_Float0;Float 0;0;0;Create;True;0;0;False;0;False;0;0.2;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-2435.412,-719.0027;Inherit;False;Property;_AbsorDistance;AbsorDistance;3;0;Create;True;0;0;False;0;False;-1.62;1.86;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;3;-1608.63,-0.6005688;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;70;-1835.085,361.8553;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-1606.621,355.7813;Inherit;False;__offset;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-1221.298,147.4579;Inherit;False;__screenPosU;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;83;-1730.438,-736.549;Inherit;False;Property;_AbsorbtionCOlor;AbsorbtionCOlor;2;0;Create;True;0;0;False;0;False;1,0,0,0;0.2431372,0.9058824,0.7158228,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;89;-1339.088,429.1177;Inherit;False;1162.256;2928.2;9angleSample;65;31;40;30;51;65;27;50;20;41;58;49;11;57;64;25;39;18;38;32;36;45;46;37;63;19;12;56;23;17;10;55;24;62;15;22;21;52;54;16;44;60;42;53;61;59;43;33;156;157;165;166;167;168;169;170;171;172;173;174;175;176;177;178;179;180;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-1224.763,223.6509;Inherit;False;__screenPosV;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;78;-2222.74,-740.8853;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-1313.608,1117.545;Inherit;False;9;__offset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-1268.536,2878.247;Inherit;False;14;__screenPosV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-1268.16,2950.858;Inherit;False;9;__offset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;-1319.563,1040.446;Inherit;False;14;__screenPosV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-1275.388,3042.639;Inherit;False;13;__screenPosU;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;-1314.144,1332.484;Inherit;False;13;__screenPosU;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;-1290.755,2591.465;Inherit;False;14;__screenPosV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;6;-1211.297,11.64502;Inherit;False;__screenPosition;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;183;-1662.099,-896.6904;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;-1282.527,2494.684;Inherit;False;9;__offset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-1270.699,1746.341;Inherit;False;9;__offset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-1325.196,1431.811;Inherit;False;9;__offset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-1282.903,2422.073;Inherit;False;13;__screenPosU;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-1305.149,843.4859;Inherit;False;9;__offset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;-1325.055,762.734;Inherit;False;13;__screenPosU;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-1276.654,1669.242;Inherit;False;14;__screenPosV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;62;-979.6265,3092.85;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-1119.028,1004.604;Inherit;False;13;__screenPosU;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;12;-1282.721,1984.968;Inherit;False;6;__screenPosition;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1076.119,1633.401;Inherit;False;13;__screenPosU;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-982.7598,2866.624;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;19;-1108.944,696.7521;Inherit;False;14;__screenPosV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;55;-983.9937,2644.676;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;10;-1279.684,2062.532;Inherit;False;9;__offset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-887.6737,1433.471;Inherit;False;14;__screenPosV;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-1118.741,772.3073;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;46;-1070.714,1716.493;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-1110.095,1082.414;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;148;-1449.348,-716.0329;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-983.127,2419.45;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;45;-1117.414,1311.365;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;49;-991.6489,2196.217;Inherit;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-1108.169,551.9366;Inherit;False;6;__screenPosition;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-878.2399,990.6074;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-819.8333,1317.782;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;84;-1026.332,-563.6829;Inherit;False;AbsorbtionColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-835.3306,1619.404;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-883.5723,705.7358;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-994.3692,1981.848;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;64;-723.3573,2873.366;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;57;-772.8839,2412.863;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;167;-565.3344,852.8311;Inherit;False;84;AbsorbtionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;65;-520.3492,2869.605;Inherit;False;Global;_GrabScreen3;Grab Screen 3;0;0;Create;True;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;180;-568.6352,2644.591;Inherit;False;84;AbsorbtionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;173;-696.7891,1884.047;Inherit;False;84;AbsorbtionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;50;-594.7629,1957.883;Inherit;False;Global;_GrabScreen7;Grab Screen 7;0;0;Create;True;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;165;-553.3344,659.8311;Inherit;False;84;AbsorbtionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;-488.7131,450.2932;Inherit;False;84;AbsorbtionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;175;-671.8909,2142.15;Inherit;False;84;AbsorbtionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;58;-578.8972,2395.95;Inherit;False;Global;_GrabScreen9;Grab Screen 9;0;0;Create;True;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;172;-660.7195,1471.054;Inherit;False;84;AbsorbtionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;30;-581.8004,525.3466;Inherit;False;Global;_GrabScreen2;Grab Screen 2;0;0;Create;True;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;40;-596.6397,1226.232;Inherit;False;Global;_GrabScreen5;Grab Screen 5;0;0;Create;True;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;51;-615.1114,2212.232;Inherit;False;Global;_GrabScreen8;Grab Screen 8;0;0;Create;True;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;41;-576.1365,1532.3;Inherit;False;Global;_GrabScreen6;Grab Screen 6;0;0;Create;True;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;178;-617.8502,2460.535;Inherit;False;84;AbsorbtionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;20;-570.9069,719.8979;Inherit;False;Global;_GrabScreen0;Grab Screen 0;0;0;Create;True;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;170;-641.2603,1147.386;Inherit;False;84;AbsorbtionColor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;27;-575.0325,911.8966;Inherit;False;Global;_GrabScreen1;Grab Screen 1;0;0;Create;True;0;0;False;0;False;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;179;-363.3119,2592.606;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;-466.5676,2090.165;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;-331.22,711.588;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-515.1942,1401.468;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-412.5268,2408.55;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;-551.2638,1814.462;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;-422.3885,1113.449;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;-261.1827,519.6512;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;-366.4054,916.1893;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-40.89996,760.0771;Inherit;False;9;9;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-12.95307,346.3593;Inherit;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;False;9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;141;-1750.855,146.0309;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;-1077.207,478.7594;Inherit;False;9;__offset;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;90;-1589.017,260.7097;Inherit;False;__offsetHalf;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;79;-1929.404,-791.4799;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-1145.741,-809.4099;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-2139.344,-452.4352;Inherit;False;Property;_AbsorbPower;AbsorbPower;1;0;Create;True;0;0;False;0;False;0;0.8951976;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;73;-2364.938,443.3915;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;28;143.3969,413.8054;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;91;-1738.37,253.2394;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.UnityObjToViewPosHlpNode;67;-1753.371,676.6215;Inherit;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;150;265.7541,119.9255;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;537.8788,-14.04191;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;SimpleBLur;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;71;0;66;0
WireConnection;71;1;74;0
WireConnection;70;0;8;0
WireConnection;70;1;71;0
WireConnection;9;0;70;0
WireConnection;13;0;3;1
WireConnection;14;0;3;2
WireConnection;78;0;77;0
WireConnection;6;0;3;0
WireConnection;183;0;78;0
WireConnection;183;1;83;0
WireConnection;62;0;59;0
WireConnection;62;1;60;0
WireConnection;63;0;61;0
WireConnection;63;1;60;0
WireConnection;55;0;54;0
WireConnection;55;1;52;0
WireConnection;17;0;15;0
WireConnection;17;1;16;0
WireConnection;46;0;42;0
WireConnection;46;1;44;0
WireConnection;24;0;22;0
WireConnection;24;1;21;0
WireConnection;148;0;183;0
WireConnection;56;0;53;0
WireConnection;56;1;52;0
WireConnection;45;0;33;0
WireConnection;45;1;43;0
WireConnection;49;0;12;0
WireConnection;49;1;10;0
WireConnection;25;0;23;0
WireConnection;25;1;24;0
WireConnection;38;0;45;0
WireConnection;38;1;37;0
WireConnection;84;0;148;0
WireConnection;39;0;36;0
WireConnection;39;1;46;0
WireConnection;18;0;17;0
WireConnection;18;1;19;0
WireConnection;11;0;12;0
WireConnection;11;1;10;0
WireConnection;64;0;62;0
WireConnection;64;1;63;0
WireConnection;57;0;56;0
WireConnection;57;1;55;0
WireConnection;65;0;64;0
WireConnection;50;0;11;0
WireConnection;58;0;57;0
WireConnection;30;0;32;0
WireConnection;40;0;38;0
WireConnection;51;0;49;0
WireConnection;41;0;39;0
WireConnection;20;0;18;0
WireConnection;27;0;25;0
WireConnection;179;0;65;0
WireConnection;179;1;180;0
WireConnection;176;0;51;0
WireConnection;176;1;175;0
WireConnection;166;0;20;0
WireConnection;166;1;165;0
WireConnection;171;0;41;0
WireConnection;171;1;172;0
WireConnection;177;0;58;0
WireConnection;177;1;178;0
WireConnection;174;0;50;0
WireConnection;174;1;173;0
WireConnection;169;0;40;0
WireConnection;169;1;170;0
WireConnection;157;0;30;0
WireConnection;157;1;156;0
WireConnection;168;0;27;0
WireConnection;168;1;167;0
WireConnection;26;0;157;0
WireConnection;26;1;166;0
WireConnection;26;2;168;0
WireConnection;26;3;169;0
WireConnection;26;4;171;0
WireConnection;26;5;174;0
WireConnection;26;6;176;0
WireConnection;26;7;177;0
WireConnection;26;8;179;0
WireConnection;79;0;78;0
WireConnection;151;0;148;0
WireConnection;28;0;26;0
WireConnection;28;1;29;0
WireConnection;0;2;28;0
ASEEND*/
//CHKSM=105D93AB2009B47A3F8649813C62E6BDDD3827D7