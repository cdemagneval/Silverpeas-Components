/**
 * Copyright (C) 2000 - 2011 Silverpeas
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * As a special exception to the terms and conditions of version 3.0 of
 * the GPL, you may redistribute this Program in connection with Free/Libre
 * Open Source Software ("FLOSS") applications as described in Silverpeas's
 * FLOSS exception.  You should have received a copy of the text describing
 * the FLOSS exception, and it is also available here:
 * "http://repository.silverpeas.com/legal/licensing"
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package com.silverpeas.crm.vo;

import com.silverpeas.crm.model.CrmEvent;
import com.stratelia.silverpeas.util.ResourcesWrapper;

public class EventVO extends ElementVO {

  private CrmEvent event;

  public EventVO(CrmEvent event, ResourcesWrapper resources) {
    super(resources);
    this.event = event;
  }

  public CrmEvent getEvent() {
    return event;
  }

  public String getAttachments() {
    return getAttachments(event.getAttachments());
  }

  public String getOperations() {
    return getOperationLinks("Event", event.getUserName(), event.getPK().getId());
  }

  public String getEventDate() {
    return getDate(event.getEventDate());
  }

  public String getActionDate() {
    return getDate(event.getActionDate());
  }

}
