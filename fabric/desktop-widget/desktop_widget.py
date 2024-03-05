#!/usr/bin/env python3

"""dead simple desktop widget that shows the time and date."""
import fabric
import os
from datetime import datetime, timedelta
from calendar import monthcalendar
from loguru import logger
from fabric.widgets.box import Box
from fabric.widgets.wayland import Window
from fabric.widgets.date_time import DateTime
from fabric.widgets.label import Label
from fabric.utils import (
    set_stylesheet_from_file,
    monitor_file,
    get_relative_path,
)

PYWAL = False


class ClockWidget(Window):
    def __init__(self, **kwargs):
        super().__init__(
            layer="bottom",
            anchor="left top right",
            margin="35px 0px 0px -200px",
            children=Box(
                children=[
                    DateTime(format_list=["%A. %d %B"], name="date", interval=10000),
                    DateTime(format_list=["%I:%M"], name="clock"),
                ],
                orientation="v",
            ),
            all_visible=True,
            exclusive=False,
        )

class CalendarWidget(Window):
    def __init__(self, **kwargs):
        self.calendar_text = ""

        self.update_calendar()

        super().__init__(
            layer="bottom",
            anchor="left top ",
            margin="40px 0px 0px 1970px",
            children=Box(
                children=[
                    # Label(self.calendar_text, name="calendar"),
                    Label(self.calendar_text, name="calendar"),
                ]
            ),
            all_visible=True,
            exclusive=False,
        )
        # self.update_calendar()

    def update_calendar(self):
        today = datetime.today()
        current_month_calendar = monthcalendar(today.year, today.month)
        self.calendar_text = self.generate_calendar_text(current_month_calendar)
        # calendar_text".set_text(calendar_text)

    def generate_calendar_text(self, month_calendar):
        today = datetime.today().day
        header = ["월", "화", "수", "목", "금", "토", "일"]
        rows = [header]
        for week in month_calendar:
            row = []
            for day in week:
                if day == 0:
                    row.append("  ")
                elif day == today:
                    row.append(f"{day:2d}")
                else:
                    row.append(f"{day:2d}")
            rows.append(row)
        calendar_text = "\n".join([" ".join(row) for row in rows])
        return calendar_text

def apply_style(*args):
    logger.info("[Desktop Widget] CSS applied")
    return set_stylesheet_from_file(get_relative_path("desktop_widget.css"))


if __name__ == "__main__":
    desktop_widget = ClockWidget()
    calendar_widget = CalendarWidget()

    if PYWAL is True:
        monitor = monitor_file(
            f"/home/{os.getlogin()}/.cache/wal/colors-widgets.css", "none"
        )
        monitor.connect("changed", apply_style)

    # initialize style
    apply_style()

    fabric.start()
