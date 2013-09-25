
package{

	import flash.display.*;
	import flash.events.*;

	[SWF(width="640",height="480")]
	
	public class MonkeyGame extends Sprite{
	
		public function MonkeyGame(){
		
			addEventListener( Event.ADDED_TO_STAGE,OnAddedToStage );
		}
		
		private function OnAddedToStage( e:Event ):void{
		
			BBMonkeyGame.Main( this );
		}
	}
}

final class Config{
//${CONFIG_BEGIN}
internal static var BINARY_FILES:String="*.bin|*.dat"
internal static var BRL_GAMETARGET_IMPLEMENTED:String="1"
internal static var CD:String=""
internal static var CONFIG:String="debug"
internal static var FLASH_RENDER_WHILE_SUSPENDED:String="0"
internal static var HOST:String="winnt"
internal static var IMAGE_FILES:String="*.png|*.jpg"
internal static var INCDIRS:String="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/native"
internal static var LANG:String="as"
internal static var MODPATH:String=".;C:/Users/Erik/Documents/GitHub/Analytics.Monkey;C:/Toolbox/Programming/MonkeyPro69/modules;C:/Toolbox/Programming/MonkeyPro69/targets/flash/modules"
internal static var MOJO_AUTO_SUSPEND_ENABLED:String="0"
internal static var MOJO_IMAGE_FILTERING_ENABLED:String="1"
internal static var MONKEYDIR:String=""
internal static var MUSIC_FILES:String="*.mp3"
internal static var SAFEMODE:String="0"
internal static var SOUND_FILES:String="*.mp3"
internal static var TARGET:String="flash"
internal static var TEXT_FILES:String="*.txt|*.xml|*.json"
internal static var TRANSDIR:String=""
//${CONFIG_END}
}

final class Assets{
//${ASSETS_BEGIN}
[Embed(source="data/mojo_font.png")]
public static var _9mojo_font3png:Class;
//${ASSETS_END}
}

//${TRANSCODE_BEGIN}

// Actionscript Monkey runtime.
//
// Placed into the public domain 24/02/2011.
// No warranty implied; use at your own risk.

//***** ActionScript Runtime *****

import flash.display.*;
import flash.external.ExternalInterface;

//Consts for radians<->degrees conversions
var D2R:Number=0.017453292519943295;
var R2D:Number=57.29577951308232;

//private
var _errInfo:String="?<?>";
var _errStack:Array=[];

var dbg_index:int=0;

function pushErr():void{
	_errStack.push( _errInfo );
}

function popErr():void{
	_errInfo=_errStack.pop();
}

function stackTrace():String{
	if( !_errInfo.length ) return "";
	var str:String=_errInfo+"\n";
	for( var i:int=_errStack.length-1;i>0;--i ){
		str+=_errStack[i]+"\n";
	}
	return str;
}

function print( str:String ):int{
	if( ExternalInterface.available ) ExternalInterface.call( "monkey_print",str );
	return 0;
}

function error( err:String ):int{
	throw err;
}

function debugLog( str:String ):int{
	print( str );
	return 0;
}

function debugStop():int{
	error( "STOP" );
	return 0;
}

function dbg_object( obj:Object ):Object{
	if( obj ) return obj;
	error( "Null object access" );
	return obj;
}

function dbg_array( arr:Array,index:int ):Array{
	if( index<0 || index>=arr.length ) error( "Array index out of range" );
	dbg_index=index;
	return arr;
}

function new_bool_array( len:int ):Array{
	var arr:Array=new Array( len )
	for( var i:int=0;i<len;++i ) arr[i]=false;
	return arr;
}

function new_number_array( len:int ):Array{
	var arr:Array=new Array( len )
	for( var i:int=0;i<len;++i ) arr[i]=0;
	return arr;
}

function new_string_array( len:int ):Array{
	var arr:Array=new Array( len );
	for( var i:int=0;i<len;++i ) arr[i]='';
	return arr;
}

function new_array_array( len:int ):Array{
	var arr:Array=new Array( len );
	for( var i:int=0;i<len;++i ) arr[i]=[];
	return arr;
}

function new_object_array( len:int ):Array{
	var arr:Array=new Array( len );
	for( var i:int=0;i<len;++i ) arr[i]=null;
	return arr;
}

function resize_bool_array( arr:Array,len:int ):Array{
	var i:int=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]=false;
	return arr;
}

function resize_number_array( arr:Array,len:int ):Array{
	var i:int=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]=0;
	return arr;
}

function resize_string_array( arr:Array,len:int ):Array{
	var i:int=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]="";
	return arr;
}

function resize_array_array( arr:Array,len:int ):Array{
	var i:int=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]=[];
	return arr;
}

function resize_object_array( arr:Array,len:int ):Array{
	var i:int=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]=null;
	return arr;
}

function string_compare( lhs:String,rhs:String ):int{
	var n:int=Math.min( lhs.length,rhs.length ),i:int,t:int;
	for( i=0;i<n;++i ){
		t=lhs.charCodeAt(i)-rhs.charCodeAt(i);
		if( t ) return t;
	}
	return lhs.length-rhs.length;
}

function string_replace( str:String,find:String,rep:String ):String{	//no unregex replace all?!?
	var i:int=0;
	for(;;){
		i=str.indexOf( find,i );
		if( i==-1 ) return str;
		str=str.substring( 0,i )+rep+str.substring( i+find.length );
		i+=rep.length;
	}
	return str;
}

function string_trim( str:String ):String{
	var i:int=0,i2:int=str.length;
	while( i<i2 && str.charCodeAt(i)<=32 ) i+=1;
	while( i2>i && str.charCodeAt(i2-1)<=32 ) i2-=1;
	return str.slice( i,i2 );
}

function string_tochars( str:String ):Array{
	var arr:Array=new Array( str.length );
	for( var i:int=0;i<str.length;++i ) arr[i]=str.charCodeAt(i);
	return arr;	
}

function string_startswith( str:String,sub:String ):Boolean{
	return sub.length<=str.length && str.slice(0,sub.length)==sub;
}

function string_endswith( str:String,sub:String ):Boolean{
	return sub.length<=str.length && str.slice(str.length-sub.length,str.length)==sub;
}

function string_fromchars( chars:Array ):String{
	var str:String="",i:int;
	for( i=0;i<chars.length;++i ){
		str+=String.fromCharCode( chars[i] );
	}
	return str;
}

class ThrowableObject{
	internal function toString():String{
		return "Uncaught Monkey Exception";
	}
}

import flash.display.*;
import flash.events.*;
import flash.media.*;
import flash.net.*;
import flash.utils.ByteArray;

import flash.ui.*;

class BBGameEvent{
	public static const KeyDown:int=1;
	public static const KeyUp:int=2;
	public static const KeyChar:int=3;
	public static const MouseDown:int=4;
	public static const MouseUp:int=5;
	public static const MouseMove:int=6;
	public static const TouchDown:int=7;
	public static const TouchUp:int=8;
	public static const TouchMove:int=9;
	public static const MotionAccel:int=10;
}

class BBGameDelegate{
	public function StartGame():void{}
	public function SuspendGame():void{}
	public function ResumeGame():void{}
	public function UpdateGame():void{}
	public function RenderGame():void{}
	public function KeyEvent( event:int,data:int ):void{}
	public function MouseEvent( event:int,data:int,x:Number,y:Number ):void{}
	public function TouchEvent( event:int,data:int,x:Number,y:Number ):void{}
	public function MotionEvent( event:int,data:int,x:Number,y:Number,z:Number ):void{}
	public function DiscardGraphics():void{}
}

class BBGame{

	internal static var _game:BBGame;

	internal var _delegate:BBGameDelegate;
	internal var _keyboardEnabled:Boolean;
	internal var _updateRate:int;
	internal var _debugExs:Boolean;
	internal var _started:Boolean;
	internal var _suspended:Boolean;
	internal var _startms:Number;
	
	public function BBGame(){
		_game=this;
		_debugExs=(Config.CONFIG=="debug");
		_startms=(new Date).getTime();
	}
	
	public static function Game():BBGame{
		return _game;
	}
	
	public function SetDelegate( delegate:BBGameDelegate ):void{
		_delegate=delegate;
	}
	
	public function Delegate():BBGameDelegate{
		return _delegate;
	}
	
	public function SetKeyboardEnabled( enabled:Boolean ):void{
		_keyboardEnabled=enabled;
	}
	
	public function SetUpdateRate( hertz:int ):void{
		_updateRate=hertz;
	}
	
	public function Started():Boolean{
		return _started;
	}
	
	public function Suspended():Boolean{
		return _suspended;
	}
	
	public function Millisecs():int{
		return (new Date).getTime()-_startms;
	}
	
	public function GetDate( date:Array ):void{
		var n:int=date.length;
		if( n>0 ){
			var t:Date=new Date();
			date[0]=t.getFullYear();
			if( n>1 ){
				date[1]=t.getMonth()+1;
				if( n>2 ){
					date[2]=t.getDate();
					if( n>3 ){
						date[3]=t.getHours();
						if( n>4 ){
							date[4]=t.getMinutes();
							if( n>5 ){
								date[5]=t.getSeconds();
								if( n>6 ){
									date[6]=t.getMilliseconds();
								}
							}
						}
					}
				}
			}
		}
	}
	
	public function SaveState( state:String ):int{
		var file:SharedObject=SharedObject.getLocal( ".monkeystate" );
		file.data.state=state;
		file.close();
		return 0;
	}
	
	public function LoadState():String{
		var file:SharedObject=SharedObject.getLocal( ".monkeystate" );
		var state:String=file.data.state;
		file.close();
		if( state ) return state;
		return "";
	}

	public function LoadString( path:String ):String{
		var buf:ByteArray=LoadData( path );
		if( buf ) return buf.toString();
		return "";
	}
	
	public function PollJoystick( port:int,joyx:Array,joyy:Array,joyz:Array,buttons:Array ):Boolean{
		return false;
	}
	
	public function OpenUrl( url:String ):void{
		navigateToURL( new URLRequest( url ) );
	}
	
	public function SetMouseVisible( visible:Boolean ):void{
		if( visible ){
			Mouse.show();
		}else{
			Mouse.hide();
		}
	}
	
	//***** Flash extensions *****
	
	public function PathToUrl( path:String ):String{
		return path;
	}
	
	public function LoadData( path:String ):ByteArray{
		//TODO: Load from URL
		return null;
	}
	
	//***** INTERNAL *****
	public function Die( ex:Object ):void{
	
		_delegate=new BBGameDelegate();
		
		if( !ex.toString() ){
			return;
		}
		if( _debugExs ){
			print( "Monkey Runtime Error : "+ex.toString() );
			print( stackTrace() );
		}
		throw ex;
	}
	
	public function StartGame():void{
	
		if( _started ) return;
		_started=true;
		
		try{
			_delegate.StartGame();
		}catch( ex:Object ){
			Die( ex );
		}
	}
	
	public function SuspendGame():void{
	
		if( !_started || _suspended ) return;
		_suspended=true;
		
		try{
			_delegate.SuspendGame();
		}catch( ex:Object ){
			Die( ex );
		}
	}
	
	public function ResumeGame():void{

		if( !_started || !_suspended ) return;
		_suspended=false;
		
		try{
			_delegate.ResumeGame();
		}catch( ex:Object ){
			Die( ex );
		}
	}
	
	public function UpdateGame():void{

		if( !_started || _suspended ) return;
		
		try{
			_delegate.UpdateGame();
		}catch( ex:Object ){
			Die( ex );
		}
	}
	
	public function RenderGame():void{

		if( !_started ) return;
		
		try{
			_delegate.RenderGame();
		}catch( ex:Object ){
			Die( ex );
		}
	}
	
	public function KeyEvent( ev:int,data:int ):void{

		if( !_started ) return;
		
		try{
			_delegate.KeyEvent( ev,data );
		}catch( ex:Object ){
			Die( ex );
		}
	}
	
	public function MouseEvent( ev:int,data:int,x:Number,y:Number ):void{

		if( !_started ) return;
		
		try{
			_delegate.MouseEvent( ev,data,x,y );
		}catch( ex:Object ){
			Die( ex );
		}
	}
	
	public function TouchEvent( ev:int,data:int,x:Number,y:Number ):void{

		if( !_started ) return;
		
		try{
			_delegate.TouchEvent( ev,data,x,y );
		}catch( ex:Object ){
			Die( ex );
		}
	}
	
	public function MotionEvent( ev:int,data:int,x:Number,y:Number,z:Number ):void{

		if( !_started ) return;
		
		try{
			_delegate.MotionEvent( ev,data,x,y,z );
		}catch( ex:Object ){
			Die( ex );
		}
	}
	
	public function DiscardGraphics():void{

		if( !_started ) return;
		
		try{
			_delegate.DiscardGraphics();
		}catch( ex:Object ){
			Die( ex );
		}
	}
}

class BBFlashGame extends BBGame{

	internal static var _flashGame:BBFlashGame;
	
	internal var _root:DisplayObjectContainer;
	
	internal var _nextUpdate:Number;
	internal var _updatePeriod:Number;

	public function BBFlashGame( root:DisplayObjectContainer ){
		_flashGame=this;
		_root=root;
	}
	
	public static function FlashGame():BBFlashGame{
		return _flashGame;
	}
	
	internal function KeyToChar( key:int ):int{
		switch( key ){
		case 8:case 9:case 13:case 27:
			return key;
		case 33:case 34:case 35:case 36:case 37:case 38:case 39:case 40:case 45:
			return key | 0x10000;
		case 46:
			return 127;
		}
		return 0;
	}
	
	internal function ValidateUpdateTimer():void{
		if( _updateRate && !_suspended ){
			_updatePeriod=1000.0/_updateRate;
			_nextUpdate=(new Date).getTime()+_updatePeriod;
			_root.stage.frameRate=_updateRate;
		}else{
			_root.stage.frameRate=24;
		}
	}
	
	//***** BBGame *****	
	
	public override function SetUpdateRate( hertz:int ):void{
		super.SetUpdateRate( hertz );
		ValidateUpdateTimer();
	}
	
	public override function PathToUrl( path:String ):String {
		if( path.indexOf( "monkey:" )!=0 ){
			return path;
		}else if( path.indexOf( "monkey://data/" )==0 ){
			return "data/"+path.slice( 14 );
		}
		return "";
	}

	public override function LoadData( path:String ):ByteArray{
		var t:Class=GetAsset( path );
		if( t ) return (new t) as ByteArray;
		return null;
	}

	public function GetDisplayObjectContainer():DisplayObjectContainer{
		return _root;
	}

	public function GetAsset( path:String ):Class{
		if( path.indexOf( "monkey://data/" )!=0 ) return null;

		path=path.slice(14);
		
		var i:int=path.indexOf( "." ),ext:String="";
		if( i!=-1 ){
			ext=path.slice(i+1);
			path=path.slice(0,i);
		}

		var munged:String="_";
		var bits:Array=path.split( "/" );
		
		for( i=0;i<bits.length;++i ){
			munged+=bits[i].length+bits[i];
		}
		munged+=ext.length+ext;
		
		return Assets[munged];
	}
	
	public function LoadBitmap( path:String ):Bitmap{
		var t:Class=GetAsset( path );
		if( t ) return (new t) as Bitmap;
		return null;
	}
	
	public function LoadSound( path:String ):Sound{
		var t:Class=GetAsset( path );
		if( t ) return (new t) as Sound;
		return null;
	}
	
	//***** INTERNAL *****
	
	public override function SuspendGame():void{
		super.SuspendGame();
		ValidateUpdateTimer();
	}
	
	public override function ResumeGame():void{
		super.ResumeGame();
		ValidateUpdateTimer();
	}

	public function Run():void{

		_root.stage.addEventListener( Event.ACTIVATE,OnActivate );
		_root.stage.addEventListener( Event.DEACTIVATE,OnDeactivate );
		_root.stage.addEventListener( Event.ENTER_FRAME,OnEnterFrame );
		_root.stage.addEventListener( KeyboardEvent.KEY_DOWN,OnKeyDown );
		_root.stage.addEventListener( KeyboardEvent.KEY_UP,OnKeyUp );
		_root.stage.addEventListener( flash.events.MouseEvent.MOUSE_DOWN,OnMouseDown );
		_root.stage.addEventListener( flash.events.MouseEvent.MOUSE_UP,OnMouseUp );
		_root.stage.addEventListener( flash.events.MouseEvent.MOUSE_MOVE,OnMouseMove );
		
		StartGame();
	}

	public function OnActivate( e:Event ):void{
		if( Config.MOJO_AUTO_SUSPEND_ENABLED=="1" ) ResumeGame();
	}
	
	public function OnDeactivate( e:Event ):void{
		if( Config.MOJO_AUTO_SUSPEND_ENABLED=="1" ) SuspendGame();
	}
	
	public function OnEnterFrame( e:Event ):void{
		if( !_updateRate || _suspended ){
			if( Config.FLASH_RENDER_WHILE_SUSPENDED=="1" ) RenderGame();
			return;
		}
		var updates:int;
		for( updates=0;updates<4;++updates ){
			_nextUpdate+=_updatePeriod;
			
			UpdateGame();
			if( !_updateRate  || _suspended ) break;
			
			if( _nextUpdate-((new Date).getTime())>0 ) break;
		}
		
		RenderGame();
		if( !_updateRate  || _suspended ) return;
		
		if( updates==4 ) _nextUpdate=(new Date).getTime();
	}
	
	public function OnKeyDown( e:KeyboardEvent ):void{
		KeyEvent( BBGameEvent.KeyDown,e.keyCode );
		if( e.charCode!=0 ){
			KeyEvent( BBGameEvent.KeyChar,e.charCode );
		}else{
			var chr:int=KeyToChar( e.keyCode );
			if( chr ) KeyEvent( BBGameEvent.KeyChar,chr );
		}
	}

	public function OnKeyUp( e:KeyboardEvent ):void{
		KeyEvent( BBGameEvent.KeyUp,e.keyCode );
	}
		
	public function OnMouseDown( e:flash.events.MouseEvent ):void{
		MouseEvent( BBGameEvent.MouseDown,0,e.localX,e.localY );
	}
		
	public function OnMouseUp( e:flash.events.MouseEvent ):void{
		MouseEvent( BBGameEvent.MouseUp,0,e.localX,e.localY );
	}

	public function OnMouseMove( e:flash.events.MouseEvent ):void{
		MouseEvent( BBGameEvent.MouseMove,-1,e.localX,e.localY );
	}

}

class BBMonkeyGame extends BBFlashGame{

	internal static var _monkeyGame:BBMonkeyGame;
	
	public function BBMonkeyGame( root:DisplayObjectContainer ){
		super( root );
	}
	
	public static function Main( root:DisplayObjectContainer ):void{
		
		_monkeyGame=new BBMonkeyGame( root );

		try{
		
			bbInit();
			bbMain();
			
		}catch( ex:Object ){
		
			_monkeyGame.Die( ex );
			return;
		}
		
		if( !_monkeyGame.Delegate() ) return;
		
		_monkeyGame.Run();
	}
}
import com.google.analytics.AnalyticsTracker;
import com.google.analytics.GATracker;
var tracker:AnalyticsTracker;

function InitGoogleAnalytics(ID:String):void{
	tracker = new GATracker( BBFlashGame.FlashGame().GetDisplayObjectContainer(), ID, "AS3", false );
	tracker.setDomainName("none");
}

function GoogleAnalyticsEvent(category:String,action:String,label:c_StringObject=null,number:c_IntObject=null,notrack:c_BoolObject=null):void{
	
	if(label==null){
		tracker.trackEvent(category, action);
	}else if(number==null){
		tracker.trackEvent(category,action,label.m_value);
	}else{
		tracker.trackEvent(category,action,label.m_value,number.m_value);
	}
}
// Flash mojo runtime.
//
// Copyright 2011 Mark Sibly, all rights reserved.
// No warranty implied; use at your own risk.

import flash.display.*;
import flash.events.*;
import flash.media.*;
import flash.geom.*;
import flash.utils.*;
import flash.net.*;

class gxtkGraphics{

	internal var game:BBFlashGame;
	internal var stage:Stage;

	internal var bitmap:Bitmap;
	
	internal var red:Number=255;
	internal var green:Number=255;
	internal var blue:Number=255;
	internal var alpha:Number=1;
	internal var colorARGB:uint=0xffffffff;
	internal var colorTform:ColorTransform=null;
	internal var alphaTform:ColorTransform=null;
	
	internal var matrix:Matrix;
	internal var rectBMData:BitmapData;
	internal var blend:String;
	internal var clipRect:Rectangle;
	
	internal var shape:Shape;
	internal var graphics:Graphics;
	internal var bitmapData:BitmapData;
	
	internal var graphics_dirty:Boolean;

	internal var pointMat:Matrix=new Matrix;
	internal var rectMat:Matrix=new Matrix;
	internal var imageMat:Matrix=new Matrix;
	internal var pointCoords:Point=new Point;
	
	internal var image_filtering_enabled:Boolean;
	
	function gxtkGraphics(){

		game=BBFlashGame.FlashGame();
		stage=game.GetDisplayObjectContainer().stage;
		
		bitmap=new Bitmap();
		bitmap.bitmapData=new BitmapData( stage.stageWidth,stage.stageHeight,false,0xff0000ff );
		bitmap.width=stage.stageWidth;
		bitmap.height=stage.stageHeight;
		game.GetDisplayObjectContainer().addChild( bitmap );

		shape=new Shape;
		graphics=shape.graphics;
		bitmapData=bitmap.bitmapData;
	
		stage.addEventListener( Event.RESIZE,OnResize );
	
		rectBMData=new BitmapData( 1,1,false,0xffffffff );
		
		image_filtering_enabled=(Config.MOJO_IMAGE_FILTERING_ENABLED=="1");
	}
	
	internal function OnResize( e:Event ):void{
		var w:int=stage.stageWidth;
		var h:int=stage.stageHeight;
		if( w==bitmap.width && h==bitmap.height ) return;
		bitmap.bitmapData=new BitmapData( w,h,false,0xff0000ff );
		bitmap.width=w;
		bitmap.height=h;
	}

	internal function BeginRender():int{
		return 1;
	}

	internal function UseGraphics():void{
		if( graphics_dirty && alphaTform ){
			bitmapData.draw( shape,matrix,alphaTform,blend,clipRect,false );
			graphics.clear();
			return;
		}
		graphics_dirty=true;
	}

	internal function FlushGraphics():void{
		if( graphics_dirty ){
			graphics_dirty=false;
			bitmapData.draw( shape,matrix,alphaTform,blend,clipRect,false );
			graphics.clear();
		}
	}
	
	internal function EndRender():void{
		FlushGraphics();
	}
	
	internal function DiscardGraphics():void{
	}
	
	internal function updateColor():void{
	
		colorARGB=(int(alpha*255)<<24)|(int(red)<<16)|(int(green)<<8)|int(blue);
		
		if( colorARGB==0xffffffff ){
			colorTform=null;
			alphaTform=null;
		}else{
			colorTform=new ColorTransform( red/255.0,green/255.0,blue/255.0,alpha );
			if( alpha==1 ){
				alphaTform=null;
			}else{
				alphaTform=new ColorTransform( 1,1,1,alpha );
			}
		}
	}

	//***** GXTK API *****

	public function Width():int{
		return bitmap.width;
	}

	public function Height():int{
		return bitmap.height;
	}
	
	public function LoadSurface__UNSAFE__( surface:gxtkSurface,path:String ):gxtkSurface{
		return null;
	}

	public function LoadSurface( path:String ):gxtkSurface{
		var bitmap:Bitmap=game.LoadBitmap( path );
		if( bitmap==null ) return null;
		return new gxtkSurface( bitmap );
	}
	
	public function CreateSurface( width:int,height:int ):gxtkSurface{
		var bitmapData:BitmapData=new BitmapData( width,height,true,0 );
		var bitmap:Bitmap=new Bitmap( bitmapData );
		return new gxtkSurface( bitmap );
	}
	
	public function SetAlpha( a:Number ):int{
		FlushGraphics();
		
		alpha=a;
		
		updateColor();
		
		return 0;
	}
	
	public function SetColor( r:Number,g:Number,b:Number ):int{
		FlushGraphics();
		
		red=r;
		green=g;
		blue=b;
		
		updateColor();
		
		return 0;
	}
	
	public function SetBlend( blend:int ):int{
		switch( blend ){
		case 1:
			this.blend=BlendMode.ADD;
			break;
		default:
			this.blend=null;
		}
		return 0;
	}
	
	public function SetScissor( x:int,y:int,w:int,h:int ):int{
		FlushGraphics();
		
		if( x!=0 || y!=0 || w!=bitmap.width || h!=bitmap.height ){
			clipRect=new Rectangle( x,y,w,h );
		}else{
			clipRect=null;
		}
		return 0;
	}

	public function SetMatrix( ix:Number,iy:Number,jx:Number,jy:Number,tx:Number,ty:Number ):int{
		FlushGraphics();
		
		if( ix!=1 || iy!=0 || jx!=0 || jy!=1 || tx!=0 || ty!=0 ){
			matrix=new Matrix( ix,iy,jx,jy,tx,ty );
		}else{
			matrix=null;
		}
		return 0;
	}

	public function Cls( r:Number,g:Number,b:Number ):int{
		FlushGraphics();

		var clsColor:uint=0xff000000|(int(r)<<16)|(int(g)<<8)|int(b);
		var rect:Rectangle=clipRect;
		if( !rect ) rect=new Rectangle( 0,0,bitmap.width,bitmap.height );
		bitmapData.fillRect( rect,clsColor );
		return 0;
	}
	
	public function DrawPoint( x:Number,y:Number ):int{
		FlushGraphics();
		
		if( matrix ){
			var px:Number=x;
			x=px * matrix.a + y * matrix.c + matrix.tx;
			y=px * matrix.b + y * matrix.d + matrix.ty;
		}
		if( clipRect || alphaTform || blend ){
			pointMat.tx=x;pointMat.ty=y;
			bitmapData.draw( rectBMData,pointMat,colorTform,blend,clipRect,false );
		}else{
			bitmapData.fillRect( new Rectangle( x,y,1,1 ),colorARGB );
		}
		return 0;
	}
	
	
	public function DrawRect( x:Number,y:Number,w:Number,h:Number ):int{
		FlushGraphics();
		
		if( matrix ){
			var mat:Matrix=new Matrix( w,0,0,h,x,y );
			mat.concat( matrix );
			bitmapData.draw( rectBMData,mat,colorTform,blend,clipRect,false );
		}else if( clipRect || alphaTform || blend ){
			rectMat.a=w;rectMat.d=h;rectMat.tx=x;rectMat.ty=y;
			bitmapData.draw( rectBMData,rectMat,colorTform,blend,clipRect,false );
		}else{
			bitmapData.fillRect( new Rectangle( x,y,w,h ),colorARGB );
		}
		return 0;
	}

	public function DrawLine( x1:Number,y1:Number,x2:Number,y2:Number ):int{
		
		if( matrix ){
		
			FlushGraphics();
			
			var x1_t:Number=x1 * matrix.a + y1 * matrix.c + matrix.tx;
			var y1_t:Number=x1 * matrix.b + y1 * matrix.d + matrix.ty;
			var x2_t:Number=x2 * matrix.a + y2 * matrix.c + matrix.tx;
			var y2_t:Number=x2 * matrix.b + y2 * matrix.d + matrix.ty;
			
			graphics.lineStyle( 1,colorARGB & 0xffffff );	//why the mask?
			graphics.moveTo( x1_t,y1_t );
			graphics.lineTo( x2_t,y2_t );
			graphics.lineStyle();
			
			bitmapData.draw( shape,null,alphaTform,blend,clipRect,false );
			graphics.clear();
			
		}else{
		
			UseGraphics();

			graphics.lineStyle( 1,colorARGB & 0xffffff );	//why the mask?
			graphics.moveTo( x1,y1 );
			graphics.lineTo( x2,y2 );
			graphics.lineStyle();
		}

		return 0;
 	}

	public function DrawOval( x:Number,y:Number,w:Number,h:Number ):int{
		UseGraphics();

		graphics.beginFill( colorARGB & 0xffffff );			//why the mask?
		graphics.drawEllipse( x,y,w,h );
		graphics.endFill();

		return 0;
	}
	
	public function DrawPoly( verts:Array ):int{
		if( verts.length<6 ) return 0;
		
		UseGraphics();
		
		graphics.beginFill( colorARGB & 0xffffff );			//why the mask?
		
		graphics.moveTo( verts[0],verts[1] );
		for( var i:int=0;i<verts.length;i+=2 ){
			graphics.lineTo( verts[i],verts[i+1] );
		}
		graphics.endFill();
		
		return 0;
	}

	public function DrawSurface( surface:gxtkSurface,x:Number,y:Number ):int{
		FlushGraphics();
		
		if( matrix ){
			var mat:Matrix=new Matrix( 1,0,0,1,x,y );
			mat.concat( matrix );
			bitmapData.draw( surface.bitmap.bitmapData,mat,colorTform,blend,clipRect,image_filtering_enabled );
		}else if( clipRect || colorTform || blend ){
			imageMat.tx=x;imageMat.ty=y;
			bitmapData.draw( surface.bitmap.bitmapData,imageMat,colorTform,blend,clipRect,image_filtering_enabled );
		}else{
			pointCoords.x=x;pointCoords.y=y;
			bitmapData.copyPixels( surface.bitmap.bitmapData,surface.rect,pointCoords );
		}

		return 0;
	}

	public function DrawSurface2( surface:gxtkSurface,x:Number,y:Number,srcx:int,srcy:int,srcw:int,srch:int ):int{
		if( srcw<0 ){ srcx+=srcw;srcw=-srcw; }
		if( srch<0 ){ srcy+=srch;srch=-srch; }
		if( srcw<=0 || srch<=0 ) return 0;
		
		FlushGraphics();

		var srcrect:Rectangle=new Rectangle( srcx,srcy,srcw,srch );
		
		if( matrix || clipRect || colorTform || blend ){

			var scratch:BitmapData=surface.scratch;
			if( scratch==null || srcw!=scratch.width || srch!=scratch.height ){
				if( scratch!=null ) scratch.dispose();
				scratch=new BitmapData( srcw,srch );
				surface.scratch=scratch;
			}
			pointCoords.x=0;pointCoords.y=0;
			scratch.copyPixels( surface.bitmap.bitmapData,srcrect,pointCoords );
			
			var mat:Matrix;
			if( matrix ){
				mat=new Matrix( 1,0,0,1,x,y );
				mat.concat( matrix );
			}else{
				imageMat.tx=x;imageMat.ty=y;
				mat=imageMat;
			}
			bitmapData.draw( scratch,mat,colorTform,blend,clipRect,image_filtering_enabled );
		}else{
			pointCoords.x=x;pointCoords.y=y;
			bitmapData.copyPixels( surface.bitmap.bitmapData,srcrect,pointCoords );
		}
		return 0;
	}
	
	public function ReadPixels( pixels:Array,x:int,y:int,width:int,height:int,offset:int,pitch:int ):int{
	
		FlushGraphics();
		
		var data:ByteArray=bitmapData.getPixels( new Rectangle( x,y,width,height ) );
		data.position=0;
		
		var px:int,py:int,j:int=offset,argb:int;
		
		for( py=0;py<height;++py ){
			for( px=0;px<width;++px ){
				pixels[j++]=data.readInt();
			}
			j+=pitch-width;
		}
		
		return 0;
	}
	
	public function WritePixels2( surface:gxtkSurface,pixels:Array,x:int,y:int,width:int,height:int,offset:int,pitch:int ):int{

		FlushGraphics();
		
		var data:ByteArray=new ByteArray();
		data.length=width*height;
			
		var px:int,py:int,j:int=offset,argb:int;
		
		for( py=0;py<height;++py ){
			for( px=0;px<width;++px ){
				data.writeInt( pixels[j++] );
			}
			j+=pitch-width;
		}
		data.position=0;
		
		surface.bitmap.bitmapData.setPixels( new Rectangle( x,y,width,height ),data );
		
		return 0;
	}
}

//***** gxtkSurface *****

class gxtkSurface{
	internal var bitmap:Bitmap;
	internal var rect:Rectangle;
	internal var scratch:BitmapData;
	
	function gxtkSurface( bitmap:Bitmap ){
		SetBitmap( bitmap );
	}
	
	public function SetBitmap( bitmap:Bitmap ):void{
		this.bitmap=bitmap;
		rect=new Rectangle( 0,0,bitmap.width,bitmap.height );
	}

	//***** GXTK API *****

	public function Discard():int{
		return 0;
	}
	
	public function Width():int{
		return rect.width;
	}

	public function Height():int{
		return rect.height;
	}

	public function Loaded():int{
		return 1;
	}
	
	public function OnUnsafeLoadComplete():Boolean{
		return true;
	}
}

class gxtkChannel{
	internal var channel:SoundChannel;	//null then not playing
	internal var sample:gxtkSample;
	internal var loops:int;
	internal var transform:SoundTransform=new SoundTransform();
	internal var pausepos:Number;
	internal var state:int;
}

class gxtkAudio{

	internal var game:BBFlashGame;
	internal var music:gxtkSample;

	internal var channels:Array=new Array( 33 );

	internal var loop_kludge:int=1;

	function gxtkAudio(){
		game=BBFlashGame.FlashGame();
		for( var i:int=0;i<33;++i ){
			channels[i]=new gxtkChannel();
		}
	}
	
	internal function SoundComplete( ev:Event ):void{
		if( !loop_kludge ) return;
		for( var i:int=0;i<33;++i ){
			var chan:gxtkChannel=channels[i];
			if( chan.state==1 && chan.channel==ev.target && chan.loops ){
				chan.channel=chan.sample.sound.play( 0,0,chan.transform );
				chan.channel.addEventListener( Event.SOUND_COMPLETE,SoundComplete );
				break;
			}
		}
	}
	
	//***** GXTK API *****
	
	public function Suspend():int{
		for( var i:int=0;i<33;++i ){
			var chan:gxtkChannel=channels[i];
			if( chan.state==1 ){
				chan.pausepos=chan.channel.position;
				chan.channel.stop();
			}
		}
		return 0;
	}
	
	public function Resume():int{
		for( var i:int=0;i<33;++i ){
			var chan:gxtkChannel=channels[i];
			if( chan.state==1 ){
				if( loop_kludge ){
					chan.channel=chan.sample.sound.play( chan.pausepos,0,chan.transform );
					if( chan.loops ) chan.channel.addEventListener( Event.SOUND_COMPLETE,SoundComplete );
				}else{
					chan.channel=chan.sample.sound.play( chan.pausepos,chan.loops,chan.transform );
				}
			}
		}
		return 0;
	}
	
	public function LoadSample__UNSAFE__( sample:gxtkSample,path:String ):gxtkSample{
		return null;
	}
	
	public function LoadSample( path:String ):gxtkSample{
		var sound:Sound=game.LoadSound( path );
		if( sound ) return new gxtkSample( sound );
		return null;
	}
	
	public function PlaySample( sample:gxtkSample,channel:int,flags:int ):int{
		var chan:gxtkChannel=channels[channel];
		
		if( chan.state!=0 ) chan.channel.stop();

		chan.sample=sample;
		chan.loops=flags ? 0x7fffffff : 0;
		chan.state=1;
		if( loop_kludge ){
			chan.channel=sample.sound.play( 0,0,chan.transform );
			chan.channel.addEventListener( Event.SOUND_COMPLETE,SoundComplete );
		}else{
			chan.channel=sample.sound.play( 0,chan.loops,chan.transform );
		}

		return 0;
	}
	
	public function StopChannel( channel:int ):int{
		var chan:gxtkChannel=channels[channel];
		
		if( chan.state!=0 ){
			chan.channel.stop();
			chan.channel=null;
			chan.sample=null;
			chan.state=0;
		}
		return 0;
	}
	
	public function PauseChannel( channel:int ):int{
		var chan:gxtkChannel=channels[channel];
		
		if( chan.state==1 ){
			chan.pausepos=chan.channel.position;
			chan.channel.stop();
			chan.state=2;
		}
		return 0;
	}
	
	public function ResumeChannel( channel:int ):int{
		var chan:gxtkChannel=channels[channel];
		
		if( chan.state==2 ){
			chan.channel=chan.sample.sound.play( chan.pausepos,chan.loops,chan.transform );
			chan.state=1;
		}
		return 0;
	}
	
	public function ChannelState( channel:int ):int{
		return -1;
	}
	
	public function SetVolume( channel:int,volume:Number ):int{
		var chan:gxtkChannel=channels[channel];
		
		chan.transform.volume=volume;

		if( chan.state!=0 ) chan.channel.soundTransform=chan.transform;

		return 0;
	}
	
	public function SetPan( channel:int,pan:Number ):int{
		var chan:gxtkChannel=channels[channel];
		
		chan.transform.pan=pan;

		if( chan.state!=0 ) chan.channel.soundTransform=chan.transform;

		return 0;
	}
	
	public function SetRate( channel:int,rate:Number ):int{
		return -1;
	}
	
	public function PlayMusic( path:String,flags:int ):int{
		StopMusic();
		
		music=LoadSample( path );
		if( !music ) return -1;
		
		PlaySample( music,32,flags );
		return 0;
	}
	
	public function StopMusic():int{
		StopChannel( 32 );
		
		if( music ){
			music.Discard();
			music=null;
		}
		return 0;
	}
	
	public function PauseMusic():int{
		PauseChannel( 32 );
		
		return 0;
	}
	
	public function ResumeMusic():int{
		ResumeChannel( 32 );
		
		return 0;
	}
	
	public function MusicState():int{
		return ChannelState( 32 );
	}
	
	public function SetMusicVolume( volume:Number ):int{
		SetVolume( 32,volume );
		return 0;
	}
}

class gxtkSample{

	internal var sound:Sound;

	function gxtkSample( sound:Sound ){
		this.sound=sound;
	}
	
	public function Discard():int{
		return 0;
	}
	
}

class BBThread{

	internal var running:Boolean=false;
	
	public function Start():void{
		running=true;
		Run__UNSAFE__();
	}
	
	public function IsRunning():Boolean{
		return running;
	}
	
	public function Run__UNSAFE__():void{
		running=false;
	}
}

class BBAsyncImageLoaderThread extends BBThread{

	internal var _device:gxtkGraphics;
	internal var _path:String;
	internal var _surface:gxtkSurface;

	override public function Start():void{
		
		var thread:BBAsyncImageLoaderThread=this;
		
		var loader:Loader=new Loader();
		
		loader.contentLoaderInfo.addEventListener( Event.COMPLETE,onLoaded );
		loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR,onIoError );
		loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR,onSecurityError );
		
		function onLoaded( e:Event ):void{
			thread._surface=new gxtkSurface( e.target.content );
			thread.running=false;
		}
		
		function onIoError( e:IOErrorEvent ):void{
			thread._surface=null;
			thread.running=false;
		}

		function onSecurityError( e:SecurityErrorEvent ):void{
			thread._surface=null;
			thread.running=false;
		}
		
		thread.running=true;
		
		loader.load( new URLRequest( BBGame.Game().PathToUrl( thread._path ) ) );
	}

}

class BBAsyncSoundLoaderThread extends BBThread{

	internal var _device:gxtkAudio;
	internal var _path:String;
	internal var _sample:gxtkSample;

	override public function Start():void{
		
		var thread:BBAsyncSoundLoaderThread=this;
		
		var sound:Sound=new Sound();
		
		sound.addEventListener( Event.COMPLETE,onLoaded );
		sound.addEventListener( IOErrorEvent.IO_ERROR,onIoError );
		sound.addEventListener( SecurityErrorEvent.SECURITY_ERROR,onSecurityError );
		
		function onLoaded( e:Event ):void{
			thread._sample=new gxtkSample( sound );
			thread.running=false;
		}
		
		function onIoError( e:IOErrorEvent ):void{
			thread._sample=null;
			thread.running=false;
		}

		function onSecurityError( e:SecurityErrorEvent ):void{
			thread._sample=null;
			thread.running=false;
		}
		
		thread.running=true;
		
		sound.load( new URLRequest( BBGame.Game().PathToUrl( thread._path ) ) );
	}
}
class c_App extends Object{
	public function m_App_new():c_App{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<99>";
		if((bb_app__app)!=null){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<99>";
			error("App has already been created");
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<100>";
		bb_app__app=this;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<102>";
		bb_app__delegate=(new c_GameDelegate).m_GameDelegate_new();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<103>";
		bb_app__game.SetDelegate(bb_app__delegate);
		popErr();
		return this;
	}
	public function p_OnCreate():int{
		pushErr();
		popErr();
		return 0;
	}
	public function p_OnSuspend():int{
		pushErr();
		popErr();
		return 0;
	}
	public function p_OnResume():int{
		pushErr();
		popErr();
		return 0;
	}
	public function p_OnUpdate():int{
		pushErr();
		popErr();
		return 0;
	}
	public function p_OnLoading():int{
		pushErr();
		popErr();
		return 0;
	}
	public function p_OnRender():int{
		pushErr();
		popErr();
		return 0;
	}
}
class c_AnalyticsTest extends c_App{
	public function m_AnalyticsTest_new():c_AnalyticsTest{
		pushErr();
		_errInfo="C:/Users/Erik/Documents/GitHub/Analytics.Monkey/analyticstest.monkey<20>";
		super.m_App_new();
		_errInfo="C:/Users/Erik/Documents/GitHub/Analytics.Monkey/analyticstest.monkey<20>";
		popErr();
		return this;
	}
	public override function p_OnCreate():int{
		pushErr();
		_errInfo="C:/Users/Erik/Documents/GitHub/Analytics.Monkey/analyticstest.monkey<22>";
		InitGoogleAnalytics("UA-XXX");
		_errInfo="C:/Users/Erik/Documents/GitHub/Analytics.Monkey/analyticstest.monkey<23>";
		GoogleAnalyticsEvent("Test","Test Ran",((new c_StringObject).m_StringObject_new3(bb_analyticstest_target)),((new c_IntObject).m_IntObject_new(1337)),((new c_BoolObject).m_BoolObject_new(true)));
		popErr();
		return 0;
	}
}
var bb_app__app:c_App;
class c_GameDelegate extends BBGameDelegate{
	public function m_GameDelegate_new():c_GameDelegate{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<26>";
		popErr();
		return this;
	}
	internal var m__graphics:gxtkGraphics=null;
	internal var m__audio:gxtkAudio=null;
	internal var m__input:c_InputDevice=null;
	public override function StartGame():void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<35>";
		m__graphics=(new gxtkGraphics);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<36>";
		bb_graphics_SetGraphicsDevice(m__graphics);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<37>";
		bb_graphics_SetFont(null,32);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<39>";
		m__audio=(new gxtkAudio);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<40>";
		bb_audio_SetAudioDevice(m__audio);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<42>";
		m__input=(new c_InputDevice).m_InputDevice_new();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<43>";
		bb_input_SetInputDevice(m__input);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<45>";
		bb_app__app.p_OnCreate();
		popErr();
	}
	public override function SuspendGame():void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<49>";
		bb_app__app.p_OnSuspend();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<50>";
		m__audio.Suspend();
		popErr();
	}
	public override function ResumeGame():void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<54>";
		m__audio.Resume();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<55>";
		bb_app__app.p_OnResume();
		popErr();
	}
	public override function UpdateGame():void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<59>";
		m__input.p_BeginUpdate();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<60>";
		bb_app__app.p_OnUpdate();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<61>";
		m__input.p_EndUpdate();
		popErr();
	}
	public override function RenderGame():void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<65>";
		var t_mode:int=m__graphics.BeginRender();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<66>";
		if((t_mode)!=0){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<66>";
			bb_graphics_BeginRender();
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<67>";
		if(t_mode==2){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<67>";
			bb_app__app.p_OnLoading();
		}else{
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<67>";
			bb_app__app.p_OnRender();
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<68>";
		if((t_mode)!=0){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<68>";
			bb_graphics_EndRender();
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<69>";
		m__graphics.EndRender();
		popErr();
	}
	public override function KeyEvent(t_event:int,t_data:int):void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<73>";
		m__input.p_KeyEvent(t_event,t_data);
		popErr();
	}
	public override function MouseEvent(t_event:int,t_data:int,t_x:Number,t_y:Number):void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<77>";
		m__input.p_MouseEvent(t_event,t_data,t_x,t_y);
		popErr();
	}
	public override function TouchEvent(t_event:int,t_data:int,t_x:Number,t_y:Number):void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<81>";
		m__input.p_TouchEvent(t_event,t_data,t_x,t_y);
		popErr();
	}
	public override function MotionEvent(t_event:int,t_data:int,t_x:Number,t_y:Number,t_z:Number):void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<85>";
		m__input.p_MotionEvent(t_event,t_data,t_x,t_y,t_z);
		popErr();
	}
	public override function DiscardGraphics():void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/app.monkey<89>";
		m__graphics.DiscardGraphics();
		popErr();
	}
}
var bb_app__delegate:c_GameDelegate;
var bb_app__game:BBGame;
internal function bbMain():int{
	pushErr();
	_errInfo="C:/Users/Erik/Documents/GitHub/Analytics.Monkey/analyticstest.monkey<17>";
	(new c_AnalyticsTest).m_AnalyticsTest_new();
	popErr();
	return 0;
}
var bb_graphics_device:gxtkGraphics;
internal function bb_graphics_SetGraphicsDevice(t_dev:gxtkGraphics):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<58>";
	bb_graphics_device=t_dev;
	popErr();
	return 0;
}
class c_Image extends Object{
	internal static var m_DefaultFlags:int;
	public function m_Image_new():c_Image{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<65>";
		popErr();
		return this;
	}
	internal var m_surface:gxtkSurface=null;
	internal var m_width:int=0;
	internal var m_height:int=0;
	internal var m_frames:Array=[];
	internal var m_flags:int=0;
	internal var m_tx:Number=.0;
	internal var m_ty:Number=.0;
	public function p_SetHandle(t_tx:Number,t_ty:Number):int{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<109>";
		dbg_object(this).m_tx=t_tx;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<110>";
		dbg_object(this).m_ty=t_ty;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<111>";
		dbg_object(this).m_flags=dbg_object(this).m_flags&-2;
		popErr();
		return 0;
	}
	public function p_ApplyFlags(t_iflags:int):int{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<184>";
		m_flags=t_iflags;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<186>";
		if((m_flags&2)!=0){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<187>";
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<187>";
			var t_:Array=m_frames;
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<187>";
			var t_2:int=0;
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<187>";
			while(t_2<t_.length){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<187>";
				var t_f:c_Frame=dbg_array(t_,t_2)[dbg_index];
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<187>";
				t_2=t_2+1;
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<188>";
				dbg_object(t_f).m_x+=1;
			}
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<190>";
			m_width-=2;
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<193>";
		if((m_flags&4)!=0){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<194>";
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<194>";
			var t_3:Array=m_frames;
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<194>";
			var t_4:int=0;
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<194>";
			while(t_4<t_3.length){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<194>";
				var t_f2:c_Frame=dbg_array(t_3,t_4)[dbg_index];
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<194>";
				t_4=t_4+1;
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<195>";
				dbg_object(t_f2).m_y+=1;
			}
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<197>";
			m_height-=2;
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<200>";
		if((m_flags&1)!=0){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<201>";
			this.p_SetHandle((m_width)/2.0,(m_height)/2.0);
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<204>";
		if(m_frames.length==1 && dbg_object(dbg_array(m_frames,0)[dbg_index]).m_x==0 && dbg_object(dbg_array(m_frames,0)[dbg_index]).m_y==0 && m_width==m_surface.Width() && m_height==m_surface.Height()){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<205>";
			m_flags|=65536;
		}
		popErr();
		return 0;
	}
	public function p_Init(t_surf:gxtkSurface,t_nframes:int,t_iflags:int):c_Image{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<142>";
		m_surface=t_surf;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<144>";
		m_width=((m_surface.Width()/t_nframes)|0);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<145>";
		m_height=m_surface.Height();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<147>";
		m_frames=new_object_array(t_nframes);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<148>";
		for(var t_i:int=0;t_i<t_nframes;t_i=t_i+1){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<149>";
			dbg_array(m_frames,t_i)[dbg_index]=(new c_Frame).m_Frame_new(t_i*m_width,0)
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<152>";
		this.p_ApplyFlags(t_iflags);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<153>";
		popErr();
		return this;
	}
	internal var m_source:c_Image=null;
	public function p_Grab(t_x:int,t_y:int,t_iwidth:int,t_iheight:int,t_nframes:int,t_iflags:int,t_source:c_Image):c_Image{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<157>";
		dbg_object(this).m_source=t_source;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<158>";
		m_surface=dbg_object(t_source).m_surface;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<160>";
		m_width=t_iwidth;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<161>";
		m_height=t_iheight;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<163>";
		m_frames=new_object_array(t_nframes);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<165>";
		var t_ix:int=t_x;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<165>";
		var t_iy:int=t_y;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<167>";
		for(var t_i:int=0;t_i<t_nframes;t_i=t_i+1){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<168>";
			if(t_ix+m_width>dbg_object(t_source).m_width){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<169>";
				t_ix=0;
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<170>";
				t_iy+=m_height;
			}
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<172>";
			if(t_ix+m_width>dbg_object(t_source).m_width || t_iy+m_height>dbg_object(t_source).m_height){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<173>";
				error("Image frame outside surface");
			}
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<175>";
			dbg_array(m_frames,t_i)[dbg_index]=(new c_Frame).m_Frame_new(t_ix+dbg_object(dbg_array(dbg_object(t_source).m_frames,0)[dbg_index]).m_x,t_iy+dbg_object(dbg_array(dbg_object(t_source).m_frames,0)[dbg_index]).m_y)
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<176>";
			t_ix+=m_width;
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<179>";
		this.p_ApplyFlags(t_iflags);
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<180>";
		popErr();
		return this;
	}
	public function p_GrabImage(t_x:int,t_y:int,t_width:int,t_height:int,t_frames:int,t_flags:int):c_Image{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<104>";
		if(dbg_object(this).m_frames.length!=1){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<104>";
			popErr();
			return null;
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<105>";
		var t_:c_Image=((new c_Image).m_Image_new()).p_Grab(t_x,t_y,t_width,t_height,t_frames,t_flags,this);
		popErr();
		return t_;
	}
}
class c_GraphicsContext extends Object{
	public function m_GraphicsContext_new():c_GraphicsContext{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<24>";
		popErr();
		return this;
	}
	internal var m_defaultFont:c_Image=null;
	internal var m_font:c_Image=null;
	internal var m_firstChar:int=0;
	internal var m_matrixSp:int=0;
	internal var m_ix:Number=1.0;
	internal var m_iy:Number=.0;
	internal var m_jx:Number=.0;
	internal var m_jy:Number=1.0;
	internal var m_tx:Number=.0;
	internal var m_ty:Number=.0;
	internal var m_tformed:int=0;
	internal var m_matDirty:int=0;
	internal var m_color_r:Number=.0;
	internal var m_color_g:Number=.0;
	internal var m_color_b:Number=.0;
	internal var m_alpha:Number=.0;
	internal var m_blend:int=0;
	internal var m_scissor_x:Number=.0;
	internal var m_scissor_y:Number=.0;
	internal var m_scissor_width:Number=.0;
	internal var m_scissor_height:Number=.0;
}
var bb_graphics_context:c_GraphicsContext;
internal function bb_data_FixDataPath(t_path:String):String{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/data.monkey<3>";
	var t_i:int=t_path.indexOf(":/",0);
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/data.monkey<4>";
	if(t_i!=-1 && t_path.indexOf("/",0)==t_i+1){
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/data.monkey<4>";
		popErr();
		return t_path;
	}
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/data.monkey<5>";
	if(string_startswith(t_path,"./") || string_startswith(t_path,"/")){
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/data.monkey<5>";
		popErr();
		return t_path;
	}
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/data.monkey<6>";
	var t_:String="monkey://data/"+t_path;
	popErr();
	return t_;
}
class c_Frame extends Object{
	internal var m_x:int=0;
	internal var m_y:int=0;
	public function m_Frame_new(t_x:int,t_y:int):c_Frame{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<18>";
		dbg_object(this).m_x=t_x;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<19>";
		dbg_object(this).m_y=t_y;
		popErr();
		return this;
	}
	public function m_Frame_new2():c_Frame{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<13>";
		popErr();
		return this;
	}
}
internal function bb_graphics_LoadImage(t_path:String,t_frameCount:int,t_flags:int):c_Image{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<234>";
	var t_surf:gxtkSurface=bb_graphics_device.LoadSurface(bb_data_FixDataPath(t_path));
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<235>";
	if((t_surf)!=null){
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<235>";
		var t_:c_Image=((new c_Image).m_Image_new()).p_Init(t_surf,t_frameCount,t_flags);
		popErr();
		return t_;
	}
	popErr();
	return null;
}
internal function bb_graphics_LoadImage2(t_path:String,t_frameWidth:int,t_frameHeight:int,t_frameCount:int,t_flags:int):c_Image{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<239>";
	var t_atlas:c_Image=bb_graphics_LoadImage(t_path,1,0);
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<240>";
	if((t_atlas)!=null){
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<240>";
		var t_:c_Image=t_atlas.p_GrabImage(0,0,t_frameWidth,t_frameHeight,t_frameCount,t_flags);
		popErr();
		return t_;
	}
	popErr();
	return null;
}
internal function bb_graphics_SetFont(t_font:c_Image,t_firstChar:int):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<532>";
	if(!((t_font)!=null)){
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<533>";
		if(!((dbg_object(bb_graphics_context).m_defaultFont)!=null)){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<534>";
			dbg_object(bb_graphics_context).m_defaultFont=bb_graphics_LoadImage("mojo_font.png",96,2);
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<536>";
		t_font=dbg_object(bb_graphics_context).m_defaultFont;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<537>";
		t_firstChar=32;
	}
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<539>";
	dbg_object(bb_graphics_context).m_font=t_font;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<540>";
	dbg_object(bb_graphics_context).m_firstChar=t_firstChar;
	popErr();
	return 0;
}
var bb_audio_device:gxtkAudio;
internal function bb_audio_SetAudioDevice(t_dev:gxtkAudio):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/audio.monkey<17>";
	bb_audio_device=t_dev;
	popErr();
	return 0;
}
class c_InputDevice extends Object{
	internal var m__joyStates:Array=new_object_array(4);
	public function m_InputDevice_new():c_InputDevice{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<20>";
		for(var t_i:int=0;t_i<4;t_i=t_i+1){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<21>";
			dbg_array(m__joyStates,t_i)[dbg_index]=(new c_JoyState).m_JoyState_new()
		}
		popErr();
		return this;
	}
	internal var m__keyDown:Array=new_bool_array(512);
	internal var m__keyHit:Array=new_number_array(512);
	public function p_BeginUpdate():void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<173>";
		for(var t_i:int=0;t_i<4;t_i=t_i+1){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<174>";
			var t_state:c_JoyState=dbg_array(m__joyStates,t_i)[dbg_index];
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<175>";
			if(!BBGame.Game().PollJoystick(t_i,dbg_object(t_state).m_joyx,dbg_object(t_state).m_joyy,dbg_object(t_state).m_joyz,dbg_object(t_state).m_buttons)){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<175>";
				break;
			}
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<176>";
			for(var t_j:int=0;t_j<32;t_j=t_j+1){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<177>";
				var t_key:int=256+t_i*32+t_j;
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<178>";
				if(dbg_array(dbg_object(t_state).m_buttons,t_j)[dbg_index]){
					_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<179>";
					if(!dbg_array(m__keyDown,t_key)[dbg_index]){
						_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<180>";
						dbg_array(m__keyDown,t_key)[dbg_index]=true
						_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<181>";
						dbg_array(m__keyHit,t_key)[dbg_index]+=1
					}
				}else{
					_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<184>";
					dbg_array(m__keyDown,t_key)[dbg_index]=false
				}
			}
		}
		popErr();
	}
	internal var m__charGet:int=0;
	internal var m__charPut:int=0;
	public function p_EndUpdate():void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<191>";
		for(var t_i:int=0;t_i<512;t_i=t_i+1){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<192>";
			dbg_array(m__keyHit,t_i)[dbg_index]=0
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<194>";
		m__charGet=0;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<195>";
		m__charPut=0;
		popErr();
	}
	internal var m__charQueue:Array=new_number_array(32);
	public function p_KeyEvent(t_event:int,t_data:int):void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<99>";
		var t_:int=t_event;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<100>";
		if(t_==1){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<101>";
			dbg_array(m__keyDown,t_data)[dbg_index]=true
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<102>";
			dbg_array(m__keyHit,t_data)[dbg_index]+=1
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<103>";
			if(t_data==1){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<104>";
				dbg_array(m__keyDown,384)[dbg_index]=true
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<105>";
				dbg_array(m__keyHit,384)[dbg_index]+=1
			}else{
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<106>";
				if(t_data==384){
					_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<107>";
					dbg_array(m__keyDown,1)[dbg_index]=true
					_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<108>";
					dbg_array(m__keyHit,1)[dbg_index]+=1
				}
			}
		}else{
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<110>";
			if(t_==2){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<111>";
				dbg_array(m__keyDown,t_data)[dbg_index]=false
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<112>";
				if(t_data==1){
					_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<113>";
					dbg_array(m__keyDown,384)[dbg_index]=false
				}else{
					_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<114>";
					if(t_data==384){
						_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<115>";
						dbg_array(m__keyDown,1)[dbg_index]=false
					}
				}
			}else{
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<117>";
				if(t_==3){
					_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<118>";
					if(m__charPut<m__charQueue.length){
						_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<119>";
						dbg_array(m__charQueue,m__charPut)[dbg_index]=t_data
						_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<120>";
						m__charPut+=1;
					}
				}
			}
		}
		popErr();
	}
	internal var m__mouseX:Number=.0;
	internal var m__mouseY:Number=.0;
	internal var m__touchX:Array=new_number_array(32);
	internal var m__touchY:Array=new_number_array(32);
	public function p_MouseEvent(t_event:int,t_data:int,t_x:Number,t_y:Number):void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<126>";
		var t_:int=t_event;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<127>";
		if(t_==4){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<128>";
			this.p_KeyEvent(1,1+t_data);
		}else{
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<129>";
			if(t_==5){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<130>";
				this.p_KeyEvent(2,1+t_data);
				popErr();
				return;
			}else{
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<132>";
				if(t_==6){
				}else{
					popErr();
					return;
				}
			}
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<136>";
		m__mouseX=t_x;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<137>";
		m__mouseY=t_y;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<138>";
		dbg_array(m__touchX,0)[dbg_index]=t_x
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<139>";
		dbg_array(m__touchY,0)[dbg_index]=t_y
		popErr();
	}
	public function p_TouchEvent(t_event:int,t_data:int,t_x:Number,t_y:Number):void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<143>";
		var t_:int=t_event;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<144>";
		if(t_==7){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<145>";
			this.p_KeyEvent(1,384+t_data);
		}else{
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<146>";
			if(t_==8){
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<147>";
				this.p_KeyEvent(2,384+t_data);
				popErr();
				return;
			}else{
				_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<149>";
				if(t_==9){
				}else{
					popErr();
					return;
				}
			}
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<153>";
		dbg_array(m__touchX,t_data)[dbg_index]=t_x
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<154>";
		dbg_array(m__touchY,t_data)[dbg_index]=t_y
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<155>";
		if(t_data==0){
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<156>";
			m__mouseX=t_x;
			_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<157>";
			m__mouseY=t_y;
		}
		popErr();
	}
	internal var m__accelX:Number=.0;
	internal var m__accelY:Number=.0;
	internal var m__accelZ:Number=.0;
	public function p_MotionEvent(t_event:int,t_data:int,t_x:Number,t_y:Number,t_z:Number):void{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<162>";
		var t_:int=t_event;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<163>";
		if(t_==10){
		}else{
			popErr();
			return;
		}
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<167>";
		m__accelX=t_x;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<168>";
		m__accelY=t_y;
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<169>";
		m__accelZ=t_z;
		popErr();
	}
}
class c_JoyState extends Object{
	public function m_JoyState_new():c_JoyState{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/inputdevice.monkey<8>";
		popErr();
		return this;
	}
	internal var m_joyx:Array=new_number_array(2);
	internal var m_joyy:Array=new_number_array(2);
	internal var m_joyz:Array=new_number_array(2);
	internal var m_buttons:Array=new_bool_array(32);
}
var bb_input_device:c_InputDevice;
internal function bb_input_SetInputDevice(t_dev:c_InputDevice):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/input.monkey<16>";
	bb_input_device=t_dev;
	popErr();
	return 0;
}
var bb_graphics_renderDevice:gxtkGraphics;
internal function bb_graphics_SetMatrix(t_ix:Number,t_iy:Number,t_jx:Number,t_jy:Number,t_tx:Number,t_ty:Number):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<307>";
	dbg_object(bb_graphics_context).m_ix=t_ix;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<308>";
	dbg_object(bb_graphics_context).m_iy=t_iy;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<309>";
	dbg_object(bb_graphics_context).m_jx=t_jx;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<310>";
	dbg_object(bb_graphics_context).m_jy=t_jy;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<311>";
	dbg_object(bb_graphics_context).m_tx=t_tx;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<312>";
	dbg_object(bb_graphics_context).m_ty=t_ty;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<313>";
	dbg_object(bb_graphics_context).m_tformed=((t_ix!=1.0 || t_iy!=.0 || t_jx!=.0 || t_jy!=1.0 || t_tx!=.0 || t_ty!=.0)?1:0);
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<314>";
	dbg_object(bb_graphics_context).m_matDirty=1;
	popErr();
	return 0;
}
internal function bb_graphics_SetMatrix2(t_m:Array):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<303>";
	bb_graphics_SetMatrix(dbg_array(t_m,0)[dbg_index],dbg_array(t_m,1)[dbg_index],dbg_array(t_m,2)[dbg_index],dbg_array(t_m,3)[dbg_index],dbg_array(t_m,4)[dbg_index],dbg_array(t_m,5)[dbg_index]);
	popErr();
	return 0;
}
internal function bb_graphics_SetColor(t_r:Number,t_g:Number,t_b:Number):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<249>";
	dbg_object(bb_graphics_context).m_color_r=t_r;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<250>";
	dbg_object(bb_graphics_context).m_color_g=t_g;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<251>";
	dbg_object(bb_graphics_context).m_color_b=t_b;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<252>";
	bb_graphics_renderDevice.SetColor(t_r,t_g,t_b);
	popErr();
	return 0;
}
internal function bb_graphics_SetAlpha(t_alpha:Number):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<266>";
	dbg_object(bb_graphics_context).m_alpha=t_alpha;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<267>";
	bb_graphics_renderDevice.SetAlpha(t_alpha);
	popErr();
	return 0;
}
internal function bb_graphics_SetBlend(t_blend:int):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<275>";
	dbg_object(bb_graphics_context).m_blend=t_blend;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<276>";
	bb_graphics_renderDevice.SetBlend(t_blend);
	popErr();
	return 0;
}
internal function bb_graphics_DeviceWidth():int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<226>";
	var t_:int=bb_graphics_device.Width();
	popErr();
	return t_;
}
internal function bb_graphics_DeviceHeight():int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<230>";
	var t_:int=bb_graphics_device.Height();
	popErr();
	return t_;
}
internal function bb_graphics_SetScissor(t_x:Number,t_y:Number,t_width:Number,t_height:Number):int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<284>";
	dbg_object(bb_graphics_context).m_scissor_x=t_x;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<285>";
	dbg_object(bb_graphics_context).m_scissor_y=t_y;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<286>";
	dbg_object(bb_graphics_context).m_scissor_width=t_width;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<287>";
	dbg_object(bb_graphics_context).m_scissor_height=t_height;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<288>";
	bb_graphics_renderDevice.SetScissor(((t_x)|0),((t_y)|0),((t_width)|0),((t_height)|0));
	popErr();
	return 0;
}
internal function bb_graphics_BeginRender():int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<212>";
	bb_graphics_renderDevice=bb_graphics_device;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<213>";
	dbg_object(bb_graphics_context).m_matrixSp=0;
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<214>";
	bb_graphics_SetMatrix(1.0,.0,.0,1.0,.0,.0);
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<215>";
	bb_graphics_SetColor(255.0,255.0,255.0);
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<216>";
	bb_graphics_SetAlpha(1.0);
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<217>";
	bb_graphics_SetBlend(0);
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<218>";
	bb_graphics_SetScissor(.0,.0,(bb_graphics_DeviceWidth()),(bb_graphics_DeviceHeight()));
	popErr();
	return 0;
}
internal function bb_graphics_EndRender():int{
	pushErr();
	_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/mojo/graphics.monkey<222>";
	bb_graphics_renderDevice=null;
	popErr();
	return 0;
}
class c_BBGameEvent extends Object{
}
var bb_analyticstest_target:String;
class c_StringObject extends Object{
	internal var m_value:String="";
	public function m_StringObject_new(t_value:int):c_StringObject{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/boxes.monkey<92>";
		dbg_object(this).m_value=String(t_value);
		popErr();
		return this;
	}
	public function m_StringObject_new2(t_value:Number):c_StringObject{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/boxes.monkey<96>";
		dbg_object(this).m_value=String(t_value);
		popErr();
		return this;
	}
	public function m_StringObject_new3(t_value:String):c_StringObject{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/boxes.monkey<100>";
		dbg_object(this).m_value=t_value;
		popErr();
		return this;
	}
	public function m_StringObject_new4():c_StringObject{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/boxes.monkey<88>";
		popErr();
		return this;
	}
}
class c_IntObject extends Object{
	internal var m_value:int=0;
	public function m_IntObject_new(t_value:int):c_IntObject{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/boxes.monkey<27>";
		dbg_object(this).m_value=t_value;
		popErr();
		return this;
	}
	public function m_IntObject_new2(t_value:Number):c_IntObject{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/boxes.monkey<31>";
		dbg_object(this).m_value=((t_value)|0);
		popErr();
		return this;
	}
	public function m_IntObject_new3():c_IntObject{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/boxes.monkey<23>";
		popErr();
		return this;
	}
}
class c_BoolObject extends Object{
	internal var m_value:Boolean=false;
	public function m_BoolObject_new(t_value:Boolean):c_BoolObject{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/boxes.monkey<11>";
		dbg_object(this).m_value=t_value;
		popErr();
		return this;
	}
	public function m_BoolObject_new2():c_BoolObject{
		pushErr();
		_errInfo="C:/Toolbox/Programming/MonkeyPro69/modules/monkey/boxes.monkey<7>";
		popErr();
		return this;
	}
}
function bbInit():void{
	bb_app__app=null;
	bb_app__delegate=null;
	bb_app__game=BBGame.Game();
	bb_graphics_device=null;
	bb_graphics_context=(new c_GraphicsContext).m_GraphicsContext_new();
	c_Image.m_DefaultFlags=0;
	bb_audio_device=null;
	bb_input_device=null;
	bb_graphics_renderDevice=null;
	bb_analyticstest_target="flash";
}
//${TRANSCODE_END}
