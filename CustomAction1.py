from robot.api.deco import keyword

@keyword
def draw_red_dot(x, y):
    """
    Draw a red dot at the specified coordinates (x, y) for debugging purposes.
    """
    script = f"""
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
    return script