/**
 * Initialize actioncable object
 * @chat_obj {obj} this.App
 * @description
 * Will initialize the actioncable obj 
 * Will bind it with passed reference obj {chat_obj}
 * Console the error if something went wrong while initialize the object
 * @return cable object
 */

function initChatObj(){
  try{
    this.App || (this.App = {});
    if (App.cable == undefined) {
      App.cable = Cable.createConsumer();       // Creates actiocable object
      console.log('*********** ActionCable Start ***************')
      console.log(App.cable);
      console.log('*********** ActionCable End ***************')
    }
    return this.App
  }
  catch (e) {
    console.log('*********** ActionCable Initialize Error Start ***************')
    console.log(e);
    console.log('*********** ActionCable Initialize Error End ***************')
  }
}
