defmodule Wimf.ExamTimeView do
  use Wimf.Web, :view

  def render("index.json", %{exam_times: exam_times}) do
    %{data: render_many(exam_times, Wimf.ExamTimeView, "exam_time.json")}
  end

  def render("show.json", %{exam_time: exam_time}) do
    %{data: render_one(exam_time, Wimf.ExamTimeView, "exam_time.json")}
  end

  def render("exam_time.json", %{exam_time: exam_time}) do
    %{id: exam_time.id,
      month: exam_time.month,
      day_of_month: exam_time.day_of_month,
      day_of_week: exam_time.day_of_week}
  end
end
