This application shows a 2D graph.

It has 4 buttons at the top which enable me to easily switch what labels are shown on the x and y axis.

You can hover over the labels on the x and y axis to get them to magnify so you can see them better, and they will become small again when you move your mouse away so that they don't take up too much space and you can focus on what is going on in the graph. 

I currently use this application for testing out geometry stuff in qml. 

TOVERLAYBASE.qml - contains most importantly a conversion function for converting between coordinate spaces. It's often convenient to think mathematically in cartesian coordinates (as this is the graphing system we all learn in school and the most common) but at the end of the day all these coordinates must be converted into pixel coordinates to be displayed on screen. On top of that, every QML object in the Qt/Qml framework has its own local pixel coordinate space.  The moral here is that you will be doing a lot of coordinate space conversions, so the convert function in this class is your friend if you plan to be able to manipulate shapes/items on screen.

RectEllipseTool.qml - Not a completed rectellipse tool yet, the plan here is to be able to plug in any geomtric formula I want and get a fully functional shape tool with a logical and useful interface for passing values back to some image processing engine, shader, etc.

 
