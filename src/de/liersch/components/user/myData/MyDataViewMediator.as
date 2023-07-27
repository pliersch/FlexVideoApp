package de.liersch.components.user.myData {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import valueObjects.User;

	[Event(name = "changeUserData", type = "de.liersch.components.user.myData.MyDataEvent")]

	public class MyDataViewMediator extends EventDispatcher {

		private var _view:MyDataView;
		private var _fileRef:FileReference;
		private var _loader:Loader;

		public function MyDataViewMediator(view:MyDataView) {
			_view = view;
			_fileRef = new FileReference();
			setupListener();
		}

		private function setupListener():void {
			_view.btnChange.addEventListener(MouseEvent.CLICK, onClickButtonChange);
			_view.btnOk.addEventListener(MouseEvent.CLICK, onClickButtonOk);
			_view.btnCancel.addEventListener(MouseEvent.CLICK, onClickButtonCancel);
			_view.btnChangeImage.addEventListener(MouseEvent.CLICK, onClickButtonImage);
		}
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                             Event Handler                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		private function onClickButtonImage(event:MouseEvent):void {
			_fileRef.browse([new FileFilter("Images", "*.jpg;*.gif;*.png")]);
			_fileRef.addEventListener(Event.SELECT, onFileSelected);
		}
		
		private function onFileSelected(e:Event):void {
			_fileRef.addEventListener(Event.COMPLETE, onFileLoaded);
			_fileRef.load();
		}
		
		private function onFileLoaded(e:Event):void {
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_loader.loadBytes(e.target.data);
		}
		
		private function onComplete(event:Event):void {
			var image:Bitmap = Bitmap(_loader.content);
			image.smoothing = true;
			_view.avatar.source = image.bitmapData;
		}

		private function onClickButtonCancel(event:MouseEvent):void {
			_view.currentState = "ViewState";
		}

		private function onClickButtonOk(event:MouseEvent):void {
			if (canChangeUserData()) {
				_view.currentState = "ViewState";
				dispatchEvent( new MyDataEvent(MyDataEvent.CHANGE_USER_DATA, getChangedUserData()));
			}
		}

		private function onClickButtonChange(event:MouseEvent):void {
			_view.currentState = "EditState";
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                            public methods                            //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		public function setUser(user:User):void {
			_view.avatar.source = user.avatarBitmapData;
			_view.txtGivenName.text = user.givenName;
			_view.txtName.text = user.name;
			_view.txtNickName.text = user.nickName;
			_view.txtEmail.text = user.email;
			_view.txtPW.text = user.password;
		}
		
		//////////////////////////////////////////////////////////////////////////
		//                                                                      //
		//                                 Helper                               //
		//                                                                      //
		//////////////////////////////////////////////////////////////////////////
		
		private function getChangedUserData():User {
			var user:User = new User();
			user.email = _view.txtEmail.text;
			user.name = _view.txtName.text;
			user.givenName = _view.txtGivenName.text;
			user.nickName = _view.txtNickName.text;
			user.password = _view.txtPW.text;
			var bitmapData:BitmapData = new BitmapData(_view.avatar.width, _view.avatar.height);
			bitmapData.draw(_view.avatar);
			user.avatarBytes = bitmapData.getPixels(bitmapData.rect);
			return user;
		}

		private function canChangeUserData():Boolean {
			return _view.txtEmail.text.length>0 && 
				_view.txtGivenName.text.length>0 &&
				_view.txtName.text.length>0 && 
				_view.txtNickName.text.length>0 &&
				_view.txtPW.text.length>0;
		}
	}
}
