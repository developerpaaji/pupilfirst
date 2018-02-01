import React from "react";
import PropTypes from "prop-types";
import Target from "./Target";

export default class TargetCollection extends React.Component {
  targets() {
    if (this.props.targets.length < 1) {
      return (
        <div className="founder-dashboard-target-noresult text-center py-3">
          <img
            className="founder-dashboard-target-noresult__icon mx-auto"
            src={this.props.iconPaths.noResults}
          />
          <h4 className="default mt-3 font-semibold">No results to display!</h4>
        </div>
      );
    } else {
      return this.props.targets.map(function(target) {
        return (
          <Target
            key={target.id}
            target={target}
            iconPaths={this.props.iconPaths}
            displayDate={this.props.displayDate}
            founderDetails={this.props.founderDetails}
            selectTargetCB={this.props.selectTargetCB}
            currentLevel={this.props.currentLevel}
          />
        );
      }, this);
    }
  }

  containerClasses() {
    let classes = "founder-dashboard-target-group__container px-2 mx-auto";

    if (this.props.finalCollection) {
      classes += " founder-dashboard-target-group__container--final";
    }

    return classes;
  }

  render() {
    return (
      <div className={this.containerClasses()}>
        <div className="founder-dashboard-target-group__box">
          <div className="founder-dashboard-target-group__header pb-4 px-3 text-center">
            {this.props.milestone && (
              <div className="founder-dashboard-target-group__milestone-label text-uppercase font-semibold">
                Milestone Targets
              </div>
            )}

            <h3 className="font-semibold mt-4 mb-0">{this.props.name}</h3>

            {this.props.description && (
              <p className="founder-dashboard-target-group__header-info">
                {this.props.description}
              </p>
            )}
          </div>

          {this.targets()}
        </div>
      </div>
    );
  }
}

TargetCollection.propTypes = {
  currentLevel: PropTypes.number,
  name: PropTypes.string,
  description: PropTypes.string,
  targets: PropTypes.array,
  displayDate: PropTypes.bool,
  milestone: PropTypes.bool,
  finalCollection: PropTypes.bool,
  iconPaths: PropTypes.object,
  founderDetails: PropTypes.array,
  selectTargetCB: PropTypes.func
};

TargetCollection.defaultProps = {
  milestone: false,
  finalCollection: false
};