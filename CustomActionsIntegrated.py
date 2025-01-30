from robot.api.deco import keyword

@keyword('Draw Dot and Click At Coordinates')  # New combined keyword
def draw_and_click_at_coordinates(x, y):
    """
    Draw a red dot at the specified coordinates (x, y) for debugging purposes,
    then simulate a click event at the same coordinates, followed by holding the LEFT mouse button,
    scrolling down with the mouse wheel, and moving the mouse down simultaneously.
    """
    # JavaScript to draw the red dot
    draw_script = f"""
    var marker = document.createElement('div');
    marker.style.position = 'absolute';
    marker.style.left = '{x}px';
    marker.style.top = '{y}px';
    marker.style.width = '20px';
    marker.style.height = '20px';
    marker.style.backgroundColor = 'blue';
    marker.style.borderRadius = '50%';
    marker.style.zIndex = '9999';
    marker.style.pointerEvents = 'none';
    marker.style.border = '2px solid black';
    document.body.appendChild(marker);
    """
    
    # JavaScript to simulate the click
    click_script = f"""
    var event = new MouseEvent('click', {{ clientX: {x}, clientY: {y}, bubbles: true, cancelable: true }});
    document.elementFromPoint({x}, {y}).dispatchEvent(event);
    """

    # JavaScript to simulate LEFT mouse button down
    mouse_down_script = f"""
    var mouseDownEvent = new MouseEvent('mousedown', {{
        clientX: {x},
        clientY: {y},
        button: 0,  // 0 = LEFT mouse button
        bubbles: true,
        cancelable: true
    }});
    document.elementFromPoint({x}, {y}).dispatchEvent(mouseDownEvent);
    """

    # JavaScript to simulate mouse wheel scroll down (page down)
    wheel_scroll_script = f"""
    var wheelEvent = new WheelEvent('wheel', {{
        deltaY: 1000,  // Positive value scrolls down
        clientX: {x},
        clientY: {y},
        bubbles: true
    }});
    document.elementFromPoint({x}, {y}).dispatchEvent(wheelEvent);
    """

    # JavaScript to simulate mouse movement down
    mouse_move_script = f"""
    var mouseMoveEvent = new MouseEvent('mousemove', {{
        clientX: {x},
        clientY: {y + 1000},  // Move 1000 pixels down
        bubbles: true,
        cancelable: true
    }});
    document.elementFromPoint({x}, {y}).dispatchEvent(mouseMoveEvent);
    """

    # JavaScript to simulate LEFT mouse button up
    mouse_up_script = f"""
    var mouseUpEvent = new MouseEvent('mouseup', {{
        clientX: {x},
        clientY: {y + 1},  // Release at the new position
        button: 0,  // 0 = LEFT mouse button
        bubbles: true,
        cancelable: true
    }});
    document.elementFromPoint({x}, {y +1}).dispatchEvent(mouseUpEvent);
    """

    # Combine all actions with minimal delays
    return f"""
    {draw_script}
    setTimeout(function() {{
        {click_script}
        setTimeout(function() {{
            {mouse_down_script}
            setTimeout(function() {{
                {wheel_scroll_script}
                {mouse_move_script}
                setTimeout(function() {{
                    {mouse_up_script}
                }}, 50);  // Delay after combined actions before releasing mouse button
            }}, 10);  // Minimal delay after mouse down before combined actions
        }}, 10);  // Minimal delay after click before mouse down
    }}, 10);  // Minimal delay after drawing before click
    """
