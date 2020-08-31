// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PortalShock"
{
	Properties
	{
		_ShockDistance("ShockDistance", Float) = 0.5
		_ShockWidth("ShockWidth", Float) = 0.2
		_Pos("Pos", Vector) = (2,0,2,0)
		_Float20("Float 20", Float) = -1
		_ShockSmooth("ShockSmooth", Float) = 0.2
		_ShockIntensity("ShockIntensity", Float) = 0.2
		_Mat("Mat", Float) = 1
		_On("On", Range( 0 , 1)) = 1
		_ScalePower("ScalePower", Float) = 0.78
		_Float0("Float 0", Float) = 0
		_ShockMaxDIstance("ShockMaxDIstance", Float) = 0
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

		uniform float _Float20;
		uniform float _Mat;
		uniform float _On;
		uniform float _ShockDistance;
		uniform float _ShockSmooth;
		uniform float _Float0;
		uniform float3 _Pos;
		uniform float _ShockWidth;
		uniform float _ShockIntensity;
		uniform float _ShockMaxDIstance;
		uniform float _ScalePower;


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
			float3 normalizeResult8_g35 = normalize( ( (float4( unity_ObjectToWorld[0][3],unity_ObjectToWorld[1][3],unity_ObjectToWorld[2][3],unity_ObjectToWorld[3][3] )).xyz - float3(2,0,2) ) );
			float3 break11_g35 = normalizeResult8_g35;
			float temp_output_24_0_g35 = ( atan2( break11_g35.z , break11_g35.x ) + _Float20 );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float Distance269 = distance( _Pos , ase_worldPos );
			float smoothstepResult20 = smoothstep( _ShockDistance , ( ( _ShockDistance + _ShockSmooth ) + _Float0 ) , Distance269);
			float3 temp_cast_0 = (smoothstepResult20).xxx;
			float3 worldToObjDir307 = mul( unity_WorldToObject, float4( temp_cast_0, 0 ) ).xyz;
			float clampResult18 = clamp( worldToObjDir307.y , 0.0 , 1.0 );
			float temp_output_9_0 = ( ( _ShockDistance + _ShockWidth ) + _ShockSmooth );
			float smoothstepResult12 = smoothstep( temp_output_9_0 , ( temp_output_9_0 + _ShockSmooth ) , Distance269);
			float3 temp_cast_1 = ((1.0 + (smoothstepResult12 - 0.0) * (0.0 - 1.0) / (1.0 - 0.0))).xxx;
			float3 worldToObjDir308 = mul( unity_WorldToObject, float4( temp_cast_1, 0 ) ).xyz;
			float clampResult19 = clamp( worldToObjDir308.y , 0.0 , 1.0 );
			float temp_output_27_0 = ( clampResult18 * clampResult19 );
			float clampResult289 = clamp( (1.0 + (Distance269 - 0.0) * (0.0 - 1.0) / (_ShockMaxDIstance - 0.0)) , 0.0 , 1.0 );
			float temp_output_35_0 = ( _Mat * ( _On * ( temp_output_27_0 * ( _ShockIntensity * clampResult289 ) ) ) );
			float4 transform365 = mul(unity_ObjectToWorld,float4( ase_worldPos , 0.0 ));
			float4 appendResult377 = (float4(( ( temp_output_35_0 * _ScalePower ) * transform365.y ) , ( temp_output_35_0 / 2.0 ) , ( ( temp_output_35_0 * _ScalePower ) * transform365.y ) , 0.0));
			float3 worldToObjDir373 = mul( unity_WorldToObject, float4( appendResult377.xyz, 0 ) ).xyz;
			float3 rotatedValue351 = RotateAroundAxis( float3( 0,0,0 ), worldToObjDir373, float3( 0,-1,0 ), temp_output_24_0_g35 );
			float3 break374 = rotatedValue351;
			float4 appendResult188 = (float4(break374.x , 0.0 , break374.z , 0.0));
			v.vertex.xyz += ( appendResult188 * v.color.r ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color44 = IsGammaSpace() ? float4(0.9811321,0.9811321,0.9811321,0) : float4(0.957614,0.957614,0.957614,0);
			o.Albedo = color44.rgb;
			float4 color49 = IsGammaSpace() ? float4(0.5188679,0.5188679,0.5188679,0) : float4(0.2319225,0.2319225,0.2319225,0);
			o.Smoothness = color49.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18400
932;75;1626;767;-3023.816;741.1697;1.043234;True;True
Node;AmplifyShaderEditor.CommentaryNode;500;399.5726,-1237.695;Inherit;False;1741.958;1880.899;Comment;6;27;332;499;501;502;512;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-61.87337,-490.4276;Inherit;False;Property;_ShockWidth;ShockWidth;2;0;Create;True;0;0;False;0;False;0.2;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;4;405.3612,-1479.377;Inherit;False;Property;_Pos;Pos;4;0;Create;True;0;0;False;0;False;2,0,2;2,0,2;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;28;-78.29028,-1049.279;Inherit;True;Property;_ShockDistance;ShockDistance;0;0;Create;True;0;0;False;0;False;0.5;-1.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;586.3564,-1433.455;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;5;825.1633,-1516.202;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;276.3193,-469.0211;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;499;450.5359,-917.8936;Inherit;False;1189.561;283.8941;InRing / Riadius;9;18;307;23;24;20;30;294;503;504;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;501;457.677,-549.6554;Inherit;False;1201.013;383.7056;Out RING / Width;6;295;11;9;19;25;26;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-79.11654,-828.238;Inherit;True;Property;_ShockSmooth;ShockSmooth;7;0;Create;True;0;0;False;0;False;0.2;0.72;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;531.9581,-412.1753;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;269;1050.118,-1514.488;Inherit;False;Distance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;504;488.4911,-704.6125;Inherit;False;Property;_Float0;Float 0;12;0;Create;True;0;0;False;0;False;0;6.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;479.2691,-794.2611;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;295;525.6445,-493.098;Inherit;False;269;Distance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;503;616.9965,-800.9971;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;657.2375,-351.015;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;294;506.4796,-915.1428;Inherit;False;269;Distance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;512;471.6837,-128.3472;Inherit;False;1211.404;431.4769;Falloff / Fade+ Intensity;8;293;292;289;283;291;290;270;511;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SmoothstepOpNode;20;743.4142,-870.5731;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;12;774.1987,-494.2779;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;270;834.1336,-62.43301;Inherit;False;269;Distance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;511;795.3038,20.41328;Inherit;False;Property;_ShockMaxDIstance;ShockMaxDIstance;13;0;Create;True;0;0;False;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;307;981.1445,-866.0562;Inherit;False;World;Object;False;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;24;1201.586,-753.8234;Inherit;False;Constant;_Float9;Float 9;0;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;1018.171,-505.0779;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;1199.48,-848.0872;Inherit;False;Constant;_Float8;Float 8;0;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;18;1347.954,-819.5573;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;308;1218.736,-489.5653;Inherit;False;World;Object;False;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;291;869.1247,201.7493;Inherit;False;Constant;_Float166;Float 166;9;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;1309.181,-319.8182;Inherit;False;Constant;_Float6;Float 6;0;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;290;874.167,118.4057;Inherit;False;Constant;_Float15;Float 15;9;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;283;1017.43,14.69329;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;1311.564,-239.7927;Inherit;False;Constant;_Float7;Float 7;0;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;332;1708.196,-700.6237;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;19;1496.784,-471.7102;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;289;1235.476,13.95361;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;292;1217.563,-63.41074;Inherit;False;Property;_ShockIntensity;ShockIntensity;8;0;Create;True;0;0;False;0;False;0.2;1.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;1791.007,-556.6836;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;293;1408.316,2.119677;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;2122.851,-651.3172;Inherit;False;Property;_On;On;10;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;300;2209.307,-550.8063;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;2376.188,-559.009;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;2394.094,-640.1151;Inherit;False;Property;_Mat;Mat;9;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;2548.064,-599.903;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;325;2528.398,-656.6819;Inherit;False;Property;_ScalePower;ScalePower;11;0;Create;True;0;0;False;0;False;0.78;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;368;2498.226,-450.9797;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;329;2747.579,-567.7094;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;328;2728.213,-667.7556;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;365;2707.822,-465.088;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;321;3007.324,-644.4597;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;428;2994.967,-518.8439;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;506;2784.524,-787.4412;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;377;3174.792,-594.2175;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;489;2681.258,68.42913;Inherit;False;Property;_Float20;Float 20;5;0;Create;True;0;0;False;0;False;-1;-0.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;508;2875.82,71.87904;Inherit;False;OrientationBasedSprite 2;-1;;35;5a23f872a4d0444948f58f0e1e2b7935;0;1;48;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformDirectionNode;373;3211.505,-224.3393;Inherit;False;World;Object;False;Fast;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RotateAboutAxisNode;351;3457.957,-215.7045;Inherit;False;False;4;0;FLOAT3;0,-1,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;2,0,2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;374;3777.183,-216.1998;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;116;-2687.506,929.6418;Inherit;False;1562.402;582.1888;move the position in tangent X direction by the deviation amount;12;153;152;146;142;136;135;134;133;132;131;130;177;delta X position;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexColorNode;179;4398.479,-241.0789;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;118;-961.9615,1032.054;Inherit;False;927.4102;507.1851;calculated new normal by derivation;8;126;125;124;123;122;121;120;119;new normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;188;4050.535,-260.9346;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;102;2012.199,-1418.533;Inherit;False;521.3383;372.4299;Fix normals for back side faces;3;104;105;103;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;115;-2671.651,1661.01;Inherit;False;1552.676;586.3004;move the position in tangent Y direction by the deviation amount;11;155;154;151;148;147;145;144;140;139;138;137;delta Y position;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;114;-3341.989,503.6908;Inherit;False;645.3955;379.0187;Comment;6;169;168;167;166;165;164;Inputs;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;113;-3810.022,993.4773;Inherit;False;1078.618;465.5402;object to tangent matrix without tangent sign;5;173;172;171;170;163;Object to tangent matrix;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;117;-2653.022,383.1265;Inherit;False;959.9028;475.1613;simply apply vertex transformation;9;161;160;159;156;129;128;127;162;178;new vertex position;1,1,1,1;0;0
Node;AmplifyShaderEditor.VertexToFragmentNode;178;-1896.079,784.2137;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;105;2039.786,-1204.964;Float;False;Constant;_Backnormalvector;Back normal vector;4;0;Create;True;0;0;False;0;False;0,0,-1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;120;-640.3266,1318.255;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.MatrixFromVectors;163;-3228.897,1134.81;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-1974.652,1821.01;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;165;-2968.949,762.1357;Float;False;deviation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;44;4622.528,-590.9297;Inherit;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;False;0;False;0.9811321,0.9811321,0.9811321,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CrossProductOpNode;172;-3414.063,1101.5;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;135;-1444.882,993.1558;Float;False;xDeviation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;162;-1901.774,509.4978;Float;False;newVertexPos;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalVertexDataNode;171;-3759.072,1293.688;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-1587.342,1089.776;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;144;-1919.652,2109.008;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;151;-1359.652,1837.01;Float;False;yDeviation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;132;-2335.506,1169.641;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;-2575.651,1757.01;Inherit;False;165;deviation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;169;-3176.948,666.1354;Float;False;Property;_Frequency;Frequency;3;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-912.3266,1128.43;Inherit;False;135;xDeviation;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;147;-1706.652,1822.01;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;155;-2623.651,1869.011;Inherit;False;173;ObjectToTangent;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;142;-1934.018,1314.578;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;-2317.022,607.1266;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;164;-3288.947,762.1357;Float;False;Property;_Normalpositiondeviation;Normal position deviation;6;0;Create;True;0;0;False;0;False;0.1;0.01;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;121;-638.4435,1129.072;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;-2154.357,1195.064;Inherit;False;173;ObjectToTangent;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SwitchByFaceNode;104;2348.845,-1360.022;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;159;-2378.446,416.433;Inherit;False;168;frequency;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-913.8056,1398.255;Inherit;False;162;newVertexPos;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;152;-2591.506,1025.641;Inherit;False;165;deviation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;126;-908.8016,1314.73;Inherit;False;151;yDeviation;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;145;-2143.651,1837.01;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;154;-2191.651,1997.01;Inherit;False;173;ObjectToTangent;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.RangedFloatNode;166;-3275.833,565.3665;Float;False;Property;_Amplitude;Amplitude;1;0;Create;True;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;4595.734,-322.3227;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;-2969.3,567.9288;Float;False;amplitude;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;502;1963.766,-595.8189;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;160;-2553.109,607.4783;Inherit;False;167;amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;156;-2386.89,511.0325;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;119;-251.3274,1140.255;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;136;-2591.506,1249.641;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;103;2039.786,-1363.964;Float;False;Constant;_Frontnormalvector;Front normal vector;4;0;Create;True;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;168;-2968.949,666.1354;Float;False;frequency;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;161;-2130.456,489.8557;Inherit;False;Waving Vertex;-1;;36;872b3757863bb794c96291ceeebfb188;0;3;1;FLOAT3;0,0,0;False;12;FLOAT;0;False;13;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;131;-2335.506,1041.641;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;122;-428.5223,1134.803;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-1904.086,1096.785;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;139;-2335.651,1917.01;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;129;-2605.022,463.127;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;140;-2335.651,1789.01;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;49;4840.33,-502.1931;Inherit;False;Constant;_Color1;Color 1;6;0;Create;True;0;0;False;0;False;0.5188679,0.5188679,0.5188679,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;133;-2143.506,1089.641;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TangentVertexDataNode;170;-3747.431,1143.312;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;173;-2978.373,1133.915;Float;False;ObjectToTangent;-1;True;1;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;146;-1470.125,1364.297;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;-910.1985,1198.721;Inherit;False;162;newVertexPos;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PosVertexDataNode;137;-2591.651,1965.01;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;127;-2557.022,687.1265;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;130;-2630.511,1139.951;Inherit;False;173;ObjectToTangent;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;5083.886,-589.5703;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;PortalShock;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;452;4619.602,2642.901;Inherit;False;503.0876;321.756;Comment;0;;1,1,1,1;0;0
WireConnection;5;0;4;0
WireConnection;5;1;1;0
WireConnection;46;0;28;0
WireConnection;46;1;6;0
WireConnection;9;0;46;0
WireConnection;9;1;31;0
WireConnection;269;0;5;0
WireConnection;30;0;28;0
WireConnection;30;1;31;0
WireConnection;503;0;30;0
WireConnection;503;1;504;0
WireConnection;11;0;9;0
WireConnection;11;1;31;0
WireConnection;20;0;294;0
WireConnection;20;1;28;0
WireConnection;20;2;503;0
WireConnection;12;0;295;0
WireConnection;12;1;9;0
WireConnection;12;2;11;0
WireConnection;307;0;20;0
WireConnection;13;0;12;0
WireConnection;18;0;307;2
WireConnection;18;1;23;0
WireConnection;18;2;24;0
WireConnection;308;0;13;0
WireConnection;283;0;270;0
WireConnection;283;2;511;0
WireConnection;332;0;18;0
WireConnection;19;0;308;2
WireConnection;19;1;25;0
WireConnection;19;2;26;0
WireConnection;289;0;283;0
WireConnection;289;1;290;0
WireConnection;289;2;291;0
WireConnection;27;0;332;0
WireConnection;27;1;19;0
WireConnection;293;0;292;0
WireConnection;293;1;289;0
WireConnection;300;0;27;0
WireConnection;300;1;293;0
WireConnection;32;0;33;0
WireConnection;32;1;300;0
WireConnection;35;0;34;0
WireConnection;35;1;32;0
WireConnection;329;0;35;0
WireConnection;329;1;325;0
WireConnection;328;0;35;0
WireConnection;328;1;325;0
WireConnection;365;0;368;0
WireConnection;321;0;328;0
WireConnection;321;1;365;2
WireConnection;428;0;329;0
WireConnection;428;1;365;2
WireConnection;506;0;35;0
WireConnection;377;0;321;0
WireConnection;377;1;506;0
WireConnection;377;2;428;0
WireConnection;508;48;489;0
WireConnection;373;0;377;0
WireConnection;351;1;508;0
WireConnection;351;3;373;0
WireConnection;374;0;351;0
WireConnection;188;0;374;0
WireConnection;188;2;374;2
WireConnection;120;0;126;0
WireConnection;120;1;124;0
WireConnection;163;0;172;0
WireConnection;163;1;170;0
WireConnection;163;2;171;0
WireConnection;148;0;145;0
WireConnection;148;1;154;0
WireConnection;165;0;164;0
WireConnection;135;0;177;0
WireConnection;177;0;134;0
WireConnection;177;1;142;1
WireConnection;151;0;147;0
WireConnection;132;0;130;0
WireConnection;132;1;136;0
WireConnection;147;0;148;0
WireConnection;147;1;144;1
WireConnection;128;0;160;0
WireConnection;128;1;127;1
WireConnection;121;0;125;0
WireConnection;121;1;123;0
WireConnection;104;0;103;0
WireConnection;104;1;105;0
WireConnection;145;0;140;0
WireConnection;145;1;139;0
WireConnection;181;0;188;0
WireConnection;181;1;179;1
WireConnection;167;0;166;0
WireConnection;502;1;27;0
WireConnection;156;0;129;0
WireConnection;119;0;122;0
WireConnection;168;0;169;0
WireConnection;161;1;156;0
WireConnection;161;12;159;0
WireConnection;161;13;128;0
WireConnection;131;0;152;0
WireConnection;122;0;120;0
WireConnection;122;1;121;0
WireConnection;134;0;133;0
WireConnection;134;1;153;0
WireConnection;139;0;155;0
WireConnection;139;1;137;0
WireConnection;140;1;138;0
WireConnection;133;0;131;0
WireConnection;133;1;132;0
WireConnection;173;0;163;0
WireConnection;0;0;44;0
WireConnection;0;4;49;0
WireConnection;0;11;181;0
ASEEND*/
//CHKSM=41AC3F8D80B8702100662B463EB1E74C71992ACF