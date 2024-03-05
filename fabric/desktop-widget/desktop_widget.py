#!/usr/bin/env python3

"""dead simple desktop widget that shows the time and date."""
import fabric
import os
import json
import subprocess
from datetime import datetime
from calendar import monthcalendar
from loguru import logger
from fabric.widgets.box import Box
from fabric.widgets.wayland import Window
from fabric.widgets.date_time import DateTime
from fabric.widgets.label import Label
from fabric.utils.fabricator import Fabricate
from fabric.utils import (
    set_stylesheet_from_file,
    monitor_file,
    get_relative_path,
)

PYWAL = False


# create a fabricator to periodically retrieve the date and time
date_fabricator    = Fabricate(poll_from="date", interval=10000)  # 10000 milliseconds , 10초
weather_fabricator = Fabricate(poll_from="date", interval=600000) # 10분



#===================================================================================================================
class ClockWidget(Window):
    def __init__(self, **kwargs):

        self.update_weather(None, None)

        super().__init__(
            layer="bottom",
            anchor="left top right",
            margin="25px 0px 0px -200px",
            children=Box(
                children=[
                    # DateTime(format_list=["%A. %d %B"], name="date", interval=10000),
                    Label(self.text, name="weather"),
                    Label(self.alt+", Seoul", name="location"),
                    # %I : 12h , %H : 24h
                    DateTime(format_list=["%H:%M"], name="clock"),
                ],
                orientation="v",
            ),
            all_visible=True,
            exclusive=False,
        )

    def update_weather(self,fabricator, value):
        # weather_output = subprocess.check_output(["/home/elsa/.config/fabric/desktop-widget/Weather.sh"])
        #
        # # 바이트 문자열을 문자열로 디코딩
        # # weather_data = weather_output.decode("utf-8").strip()
        # weather_data = json.loads(weather_output)
        # print(weather_data)
        #
        # # 각 필드를 변수에 할당
        # self.text  = weather_data["text"]
        # self.alt   = weather_data["alt"]
        # # tooltip = weather_data["tooltip"]
        self.text = "test"
        self.alt  = "yangchun-gu"



#===================================================================================================================
class CalendarWidget(Window):
    def __init__(self, **kwargs):
        self.calendar_text = ""

        self.update_calendar()

        super().__init__(
            layer="bottom",
            anchor="left top ",
            margin="30px 0px 0px 1970px",
            children=Box(
                children=[
                    Label(self.calendar_text, name="calendar"),
                ]
            ),
            all_visible=True,
            exclusive=False,
        )

    def update_calendar(self):
        today = datetime.today()
        current_month_calendar = monthcalendar(today.year, today.month)
        self.calendar_text = self.generate_calendar_text(current_month_calendar)

    def generate_calendar_text(self, month_calendar):
        header = ["월", "화", "수", "목", "금", "토", "일"]
        rows = [header]
        for week in month_calendar:
            row = []
            for day in week:
                if day == 0:
                    row.append("  ")
                else:
                    row.append(f"{day:2d}")
            rows.append(row)

        calendar_text = "\n".join([" ".join(row) for row in rows])
        print (calendar_text)

        return calendar_text



#===================================================================================================================
class CalendarWidgetToday(Window):
    def __init__(self, **kwargs):
        self.calendar_text = ""

        self.update_calendar(None, None)

        super().__init__(
            layer="bottom",
            anchor="left top ",
            margin="30px 0px 0px 1970px",
            children=Box(
                children=[
                    Label(self.calendar_text, name="calendar-today"),
                ]
            ),
            all_visible=True,
            exclusive=False,
        )

    def update_calendar(self, fabricator, value):
        today = datetime.today()
        current_month_calendar = monthcalendar(today.year, today.month)
        self.calendar_text = self.generate_calendar_text(current_month_calendar)

    def generate_calendar_text(self, month_calendar):
        today = datetime.today().day
        header = ["  ", "  ", "  ", "  ", "  ", "  ", "  "]
        rows = [header]
        for week in month_calendar:
            row = []
            for day in week:
                if day == 0:
                    row.append("  ")
                elif day == today:
                   row.append(f"{day:2d}")
                else:
                    row.append("  ")
            rows.append(row)

        calendar_text = "\n".join([" ".join(row) for row in rows])
        return calendar_text


#===================================================================================================================
class CalendarWidgetOverlay(Window):
    def __init__(self, **kwargs):
        self.calendar_text = ""

        self.update_calendar()

        super().__init__(
            layer="bottom",
            anchor="left top ",
            margin="30px 0px 0px 1970px",
            children=Box(
                children=[
                    Label(self.calendar_text, name="calendar-overlay"),
                ]
            ),
            all_visible=True,
            exclusive=False,
        )

    def update_calendar(self):
        today = datetime.today()
        current_month_calendar = monthcalendar(today.year, today.month)
        self.calendar_text = self.generate_calendar_text(current_month_calendar)

    def generate_calendar_text(self, month_calendar):
        header = ["  ", "  ", "  ", "  ", "  ", "  ", "  "]
        rows = [header]
        for week in month_calendar:
            row = []
            for day in week:
                if day == 0:
                    row.append("  ")
                elif datetime.today().replace(day=day).weekday() in [5, 6]:
                    row.append(f"{day:2d}")
                else:
                    row.append("  ")
            rows.append(row)

        calendar_text = "\n".join([" ".join(row) for row in rows])
        return calendar_text


#===================================================================================================================
def apply_style(*args):
    logger.info("[Desktop Widget] CSS applied")
    return set_stylesheet_from_file(get_relative_path("desktop_widget.css"))




#===================================================================================================================
if __name__ == "__main__":
    desktop_widget         = ClockWidget()
    calendar_widget        = CalendarWidget()
    calendaroverlay_widget = CalendarWidgetOverlay()
    calendartoday_widget   = CalendarWidgetToday()

    if PYWAL is True:
        monitor = monitor_file(
            f"/home/{os.getlogin()}/.cache/wal/colors-widgets.css", "none"
        )
        monitor.connect("changed", apply_style)

    # initialize style
    apply_style()

    date_fabricator.connect("changed", calendartoday_widget.update_calendar)
    weather_fabricator.connect("changed", desktop_widget.update_weather)

    fabric.start()
