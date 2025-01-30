from robot.api.deco import keyword

@keyword('Draw Dot and Click At Coordinates')  # New combined keyword
def draw_and_click_at_coordinates(x, y):
    """
    Draw a red dot at the specified coordinates (x, y) for debugging purposes,
    then simulate a click event at the same coordinates.
    """
    # JavaScript to draw the red dot
    draw_script = f"""
    var marker = document.createElement('div');
    marker.style.position = 'absolute';
    marker.style.left = '{x}px';
    marker.style.top = '{y}px';
    marker.style.width = '20px';
    marker.style.height = '20px';
    marker.style.backgroundColor = 'red';
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

    # Combine both actions with a small delay between the dot drawing and the click
    return f"""
    {draw_script}
    setTimeout(function() {{
        {click_script}
    }}, 500);  // Delay before clicking
    """
