from robot.api.deco import keyword

@keyword('Click Page At Coordinates')  # Decorator with spaces
def click_page_at_coordinates(x, y):
    """
    Simulate a click event at the specified coordinates (x, y).
    """
    print(f"Clicking at coordinates: {x}, {y}")  # Debugging line
    return f"var event = new MouseEvent('click', {{ clientX: {x}, clientY: {y}, bubbles: true, cancelable: true }}); document.elementFromPoint({x}, {y}).dispatchEvent(event);"
