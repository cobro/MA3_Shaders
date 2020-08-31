// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/VertexNormalReconstruction"
{
	Properties
	{
		_Amplitude("Amplitude", Range( 0 , 10)) = 0
		_Frequency("Frequency", Float) = 0
		_Flagalbedo("Flag albedo", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		ZTest LEqual
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half ASEVFace : VFACE;
			float2 uv_texcoord;
		};

		uniform float _Frequency;
		uniform float _Amplitude;
		uniform sampler2D _Flagalbedo;
		uniform float4 _Flagalbedo_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 break3_g20 = ase_vertex3Pos;
			float frequency291 = _Frequency;
			float mulTime4_g20 = _Time.y * 2.0;
			float amplitude287 = _Amplitude;
			float3 appendResult11_g20 = (float3(break3_g20.x , ( break3_g20.y + ( sin( ( ( break3_g20.x * frequency291 ) + mulTime4_g20 ) ) * ( amplitude287 * v.texcoord.xy.x ) ) ) , break3_g20.z));
			float3 newVertexPos56 = appendResult11_g20;
			v.vertex.xyz = newVertexPos56;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 switchResult315 = (((i.ASEVFace>0)?(float3(0,0,1)):(float3(0,0,-1))));
			o.Normal = switchResult315;
			float2 uv_Flagalbedo = i.uv_texcoord * _Flagalbedo_ST.xy + _Flagalbedo_ST.zw;
			o.Albedo = tex2D( _Flagalbedo, uv_Flagalbedo ).rgb;
			o.Smoothness = 0.5;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18400
1367;75;1191;788;2035.519;1148.4;2.071896;False;True
Node;AmplifyShaderEditor.CommentaryNode;295;-2013.657,-317.0975;Inherit;False;645.3955;379.0187;Comment;6;130;199;127;291;112;287;Inputs;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-1960.615,-250.6531;Float;False;Property;_Amplitude;Amplitude;0;0;Create;True;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;77;-1261.203,-570.4066;Inherit;False;959.9028;475.1613;simply apply vertex transformation;8;56;15;306;294;290;307;319;321;new vertex position;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-1848.616,-154.6529;Float;False;Property;_Frequency;Frequency;1;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;287;-1640.968,-252.8594;Float;False;amplitude;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;291;-1640.617,-154.6529;Float;False;frequency;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;307;-1165.203,-266.4068;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;15;-1213.203,-490.4066;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;290;-1161.29,-346.0551;Inherit;False;287;amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;306;-938.1451,-372.2902;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;319;-995.0714,-442.5011;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;294;-997.2871,-477.7195;Inherit;False;291;frequency;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;318;1185.801,-1317.589;Inherit;False;461.3383;368.4299;Fix normals for back side faces;3;315;317;316;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;321;-746.5966,-427.6398;Inherit;False;Waving Vertex;-1;;20;872b3757863bb794c96291ceeebfb188;0;3;1;FLOAT3;0,0,0;False;12;FLOAT;0;False;13;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-526.4932,-490.4066;Float;False;newVertexPos;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;317;1201.801,-1109.589;Float;False;Constant;_Backnormalvector;Back normal vector;4;0;Create;True;0;0;False;0;False;0,0,-1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;316;1201.801,-1269.589;Float;False;Constant;_Frontnormalvector;Front normal vector;4;0;Create;True;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;177;-1261.203,85.59328;Inherit;False;1562.402;582.1888;move the position in tangent X direction by the deviation amount;14;308;289;309;113;197;293;196;195;198;194;192;200;201;322;delta X position;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;296;-2429.745,230.4046;Inherit;False;1078.618;465.5402;object to tangent matrix without tangent sign;5;116;121;125;118;117;Object to tangent matrix;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;202;-1245.203,805.5933;Inherit;False;1552.676;586.3004;move the position in tangent Y direction by the deviation amount;14;311;310;114;292;210;288;209;208;206;207;205;203;204;320;delta Y position;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;297;393.5374,-272.7992;Inherit;False;927.4102;507.1851;calculated new normal by derivation;8;223;107;224;108;88;93;96;97;new normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;292;-493.2034,1093.593;Inherit;False;291;frequency;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;200;-1189.203,136.5932;Inherit;False;199;deviation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;93;715.1715,13.40117;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;88;715.1715,-162.599;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TangentVertexDataNode;118;-2367.155,380.2391;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CrossProductOpNode;96;907.171,-82.59892;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalVertexDataNode;117;-2378.795,530.6161;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CrossProductOpNode;125;-2033.787,338.4271;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;311;-493.2034,1253.593;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;322;-159.5187,287.6191;Inherit;False;Waving Vertex;-1;;22;872b3757863bb794c96291ceeebfb188;0;3;1;FLOAT3;0,0,0;False;12;FLOAT;0;False;13;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;108;443.1715,93.40125;Inherit;False;56;newVertexPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;305;1354.175,-1537.7;Inherit;True;Property;_Flagalbedo;Flag albedo;3;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwitchByFaceNode;315;1489.801,-1189.589;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;293;-461.2034,357.5933;Inherit;False;291;frequency;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;288;-493.2034,1173.593;Inherit;False;287;amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;309;-477.2034,517.5933;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;289;-461.2034,437.5932;Inherit;False;287;amplitude;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;308;-253.2034,421.5932;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;310;-285.2035,1141.593;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;97;1131.171,-82.59892;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;443.5374,-106.1326;Inherit;False;56;newVertexPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;19;1407.801,-933.5897;Float;False;Constant;_Smoothness;Smoothness;0;0;Create;True;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;320;-147.1786,1041.861;Inherit;False;Waving Vertex;-1;;21;872b3757863bb794c96291ceeebfb188;0;3;1;FLOAT3;0,0,0;False;12;FLOAT;0;False;13;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;-765.2032,389.5933;Inherit;False;121;ObjectToTangent;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;195;-729.2032,223.5933;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;209;-717.2032,981.5933;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;205;-1165.203,1109.593;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;203;-1149.203,901.5933;Inherit;False;199;deviation;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;-920.2032,298.5933;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,0,0,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;204;-1197.203,1013.593;Inherit;False;121;ObjectToTangent;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.PosVertexDataNode;201;-1165.203,405.5932;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;198;-909.2032,197.5933;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;207;-909.2032,1061.593;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,0,0,1,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;206;-909.2032,933.5933;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;-1600.481,373.0467;Float;False;ObjectToTangent;-1;True;1;0;FLOAT3x3;0,0,0,1,0,0,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.GetLocalVarNode;223;443.1715,-178.599;Inherit;False;113;xDeviation;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;199;-1640.617,-58.65263;Float;False;deviation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;208;-765.2032,1141.593;Inherit;False;121;ObjectToTangent;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.GetLocalVarNode;109;1390.545,-837.5897;Inherit;False;56;newVertexPos;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;197;-433.2035,223.5933;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3x3;0,0,0,1,0,0,1,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;-464.8759,948.7198;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3x3;0,0,0,1,0,0,1,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-1960.615,-58.65263;Float;False;Property;_Normalpositiondeviation;Normal position deviation;2;0;Create;True;0;0;False;0;False;0.1;0;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;60.32577,892.6189;Float;False;yDeviation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;66.79664,245.5933;Float;False;xDeviation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.MatrixFromVectors;116;-1848.621,371.7368;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.GetLocalVarNode;192;-1214.208,254.0956;Inherit;False;121;ObjectToTangent;1;0;OBJECT;;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.GetLocalVarNode;224;443.1715,13.40117;Inherit;False;114;yDeviation;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1770.872,-1177.225;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;ASESampleShaders/VertexNormalReconstruction;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;287;0;112;0
WireConnection;291;0;127;0
WireConnection;306;0;290;0
WireConnection;306;1;307;1
WireConnection;319;0;15;0
WireConnection;321;1;319;0
WireConnection;321;12;294;0
WireConnection;321;13;306;0
WireConnection;56;0;321;0
WireConnection;93;0;224;0
WireConnection;93;1;108;0
WireConnection;88;0;223;0
WireConnection;88;1;107;0
WireConnection;96;0;93;0
WireConnection;96;1;88;0
WireConnection;322;1;197;0
WireConnection;322;12;293;0
WireConnection;322;13;308;0
WireConnection;315;0;316;0
WireConnection;315;1;317;0
WireConnection;308;0;289;0
WireConnection;308;1;309;1
WireConnection;310;0;288;0
WireConnection;310;1;311;1
WireConnection;97;0;96;0
WireConnection;320;1;210;0
WireConnection;320;12;292;0
WireConnection;320;13;310;0
WireConnection;195;0;198;0
WireConnection;195;1;194;0
WireConnection;209;0;206;0
WireConnection;209;1;207;0
WireConnection;194;0;192;0
WireConnection;194;1;201;0
WireConnection;198;0;200;0
WireConnection;207;0;204;0
WireConnection;207;1;205;0
WireConnection;206;1;203;0
WireConnection;121;0;116;0
WireConnection;199;0;130;0
WireConnection;197;0;195;0
WireConnection;197;1;196;0
WireConnection;210;0;209;0
WireConnection;210;1;208;0
WireConnection;114;0;210;0
WireConnection;113;0;197;0
WireConnection;116;0;125;0
WireConnection;116;1;118;0
WireConnection;116;2;117;0
WireConnection;0;0;305;0
WireConnection;0;1;315;0
WireConnection;0;4;19;0
WireConnection;0;11;109;0
ASEEND*/
//CHKSM=129531FABEA05462D021D7C9A6BA56A74D433D7C