module Rahmen
  class Camera
    def self.capture
      capture = ::OpenCV::CvCapture.open
      mat = capture.query.to_CvMat
      mat.save('out.jpg')
    end
  end
end
