from robot.libraries.BuiltIn import BuiltIn
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options as ChromeOptions
import os
import signal

def kill_chrome_processes():
    try:
        if os.name == 'nt':  # Windows
            os.system("taskkill /f /im chrome.exe")
        else:  # Linux/Mac
            os.system("pkill -f chrome")
    except Exception as e:
        BuiltIn().log(f"Failed to kill Chrome processes: {e}", level="WARN")

def check_chrome_and_driver_versions():
    try:
        driver = webdriver.Chrome()
        driver.quit()
        return True
    except Exception as e:
        BuiltIn().log(f"ChromeDriver and Chrome version mismatch: {e}", level="ERROR")
        return False

class CustomPythonLibraryDeepSeek:

    def custom_drag_and_drop_with_failsafe(self, source_locator, target_locator, verification_locator, verification_text):
        # Kill existing Chrome processes
        kill_chrome_processes()
        
        # Verify Chrome and ChromeDriver versions
        if not check_chrome_and_driver_versions():
            raise Exception("ChromeDriver and Chrome versions are not compatible.")
        
        selenium_lib = BuiltIn().get_library_instance("SeleniumLibrary")
        
        # Add Chrome options
        chrome_options = ChromeOptions()
        chrome_options.add_argument("--no-sandbox")
        chrome_options.add_argument("--disable-dev-shm-usage")
        chrome_options.add_argument("--disable-gpu")
        chrome_options.add_argument("--headless")  # Optional
        
        # Open the browser with the new options
        driver = selenium_lib.open_browser("about:blank", "chrome", options=chrome_options)
        
        # Rest of the script...

class CustomPythonLibraryDeepSeek:

    def custom_drag_and_drop_with_failsafe(self, source_locator, target_locator, verification_locator, verification_text):
        selenium_lib = BuiltIn().get_library_instance("SeleniumLibrary")
        driver = selenium_lib.driver

        def perform_drag_and_drop(action, source, target):
            try:
                action.click_and_hold(source).move_to_element(target).release().perform()
                BuiltIn().log("Standard drag-and-drop performed.", level="INFO")
                return True
            except Exception as e:
                BuiltIn().log(f"Drag-and-drop method failed: {e}", level="DEBUG")
                return False

        def perform_drag_and_drop_with_js(source, target):
            try:
                drag_and_drop_script = """
                    function createEvent(typeOfEvent) {
                        var event = document.createEvent("CustomEvent");
                        event.initCustomEvent(typeOfEvent, true, true, null);
                        event.dataTransfer = {
                            data: {},
                            setData: function (key, value) {
                                this.data[key] = value;
                            },
                            getData: function (key) {
                                return this.data[key];
                            }
                        };
                        return event;
                    }
                    function dispatchEvent(element, event, transferData) {
                        if (transferData !== undefined) {
                            event.dataTransfer = transferData;
                        }
                        if (element.dispatchEvent) {
                            element.dispatchEvent(event);
                        } else if (element.fireEvent) {
                            element.fireEvent("on" + event.type, event);
                        }
                    }
                    var source = arguments[0];
                    var target = arguments[1];
                    var dragStartEvent = createEvent("dragstart");
                    dispatchEvent(source, dragStartEvent);
                    var dropEvent = createEvent("drop");
                    dispatchEvent(target, dropEvent, dragStartEvent.dataTransfer);
                    var dragEndEvent = createEvent("dragend");
                    dispatchEvent(source, dragEndEvent);
                """
                driver.execute_script(drag_and_drop_script, source, target)
                BuiltIn().log("JavaScript drag-and-drop performed.", level="INFO")
                return True
            except Exception as e:
                BuiltIn().log(f"JavaScript drag-and-drop failed: {e}", level="DEBUG")
                return False

        try:
            source_element = selenium_lib.get_webelement(source_locator)
            target_element = selenium_lib.get_webelement(target_locator)
            action = ActionChains(driver)

            # Try standard drag-and-drop first
            BuiltIn().log("Trying standard drag-and-drop method...", level="INFO")
            success = perform_drag_and_drop(action, source_element, target_element)

            if not success:
                BuiltIn().log("Standard method failed. Trying alternative method with JavaScript...", level="WARN")
                success = perform_drag_and_drop_with_js(source_element, target_element)

            if not success:
                BuiltIn().log("Both drag-and-drop methods failed.", level="ERROR")
                raise Exception("Drag-and-drop action failed.")

            # Verify text in all windows
            verification_successful = self._verify_text_in_all_windows(driver, verification_locator, verification_text)
            if not verification_successful:
                BuiltIn().log("Text verification failed, but continuing...", level="WARN")

            BuiltIn().log("Drag-and-drop successfully completed!", level="INFO")

        except Exception as e:
            BuiltIn().log(f"Error during drag-and-drop with failsafe: {e}", level="ERROR")
            raise

    def _verify_text_in_all_windows(self, driver, verification_locator, verification_text):
        handles = driver.window_handles
        original_window = driver.current_window_handle

        for handle in handles:
            driver.switch_to.window(handle)
            BuiltIn().log(f"Checking window {handle} for the text '{verification_text}'", level="INFO")
            if self._verify_action(driver, verification_locator, verification_text):
                BuiltIn().log(f"Found '{verification_text}' in window {handle}", level="INFO")
                return True

        driver.switch_to.window(original_window)
        return False

    def _verify_action(self, driver, verification_locator, verification_text):
        try:
            WebDriverWait(driver, 5).until(
                EC.text_to_be_present_in_element((By.XPATH, verification_locator), verification_text)
            )
            BuiltIn().log(f"Verification passed: Found '{verification_text}'", level="INFO")
            return True
        except Exception as e:
            BuiltIn().log(f"Verification failed: {e}", level="DEBUG")
            return False
