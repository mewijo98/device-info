import platform
import psutil

def get_system_specs():
    """Returns a dictionary of core system specifications."""
    return {
        "OS": platform.system(),
        "OS Version": platform.version(),
        "Processor": platform.processor(),
        "Machine": platform.machine(),
        "RAM": f"{round(psutil.virtual_memory().total / (1024**3), 2)} GB"
    }
    