from selenium.webdriver.common.action_chains import ActionChains
from robot.api.deco import keyword
from SeleniumLibrary import SeleniumLibrary

class CustomPythonLibrary:

    @keyword
    def custom_drag_and_drop(self, source, target):
        # Create an instance of SeleniumLibrary
        selenium_lib = SeleniumLibrary()

        # Get the driver by calling selenium_lib's 'driver' method
        driver = selenium_lib._current_browser()

        # Perform the drag and drop action
        action = ActionChains(driver)
        action.drag_and_drop(source, target).perform()


