
extends RigidBody2D

func _ready():
   set_process_input(true)

func _input(event):
   # if user left clicks
   if(event.type == InputEvent.MOUSE_BUTTON):
      if(event.button_index == 1):
         self.set_pos(Vector2(event.x,event.y)) 
         
   # on keyboard cursor key
   if(event.type == InputEvent.KEY):
      var curPos = self.get_pos()
      
      if(event.scancode == KEY_RIGHT):
         curPos.x+= 10
         self.set_pos(curPos)

      if(event.scancode == KEY_LEFT):
         curPos.x-= 10
         self.set_pos(curPos)

      if(event.scancode == KEY_UP):
         curPos.y-= 10
         self.set_pos(curPos)

      if(event.scancode == KEY_DOWN):
         curPos.y+= 10
         self.set_pos(curPos)